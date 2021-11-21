//
//  SearchViewModel.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation
import Combine

class SearchViewModel {
    @Published private(set) var state: SearchViewState = .initialized {
        didSet { self.stateDidChange(to: self.state) }
    }
    
    @Published private(set) var trending: [[String]] = .init(repeating: [], count: 2)
    @Published private(set) var gifs: [ImageProviderImage] = []
    @Published private(set) var history: [String] = []
    
    @Published private(set) var openViewer: PassthroughSubject<ImageProviderImage, Never> = .init()
    @Published private(set) var openSearchAssistant: PassthroughSubject<Bool, Never> = .init()
    
    private let searchImage: SearchImageUseCase
    private let searchTrendingTerms: SearchTrendingUseCase = .init()
    private let searchHistory: UserHistoryUseCase = .init(storage: LocalStorage())
    
    init(searchImage: SearchImageUseCase) {
        self.searchImage = searchImage
    }
    
    func userDidTouchItem(at index: Int) {
        self.openViewer.send(self.gifs[index])
    }
    
    func userDidChangeSearchViewState(text: String, isInputActive: Bool) {
        switch isInputActive {
        case true:
            if text.isEmpty { self.state = .waitingQuery }
            else { self.state = .waitingSearch }
        case false:
            if text.isEmpty { self.state = .initialized }
            else { self.state = .searched }
        }
    }
    
    func userDidChangeSearchType(to type: Int, query: String) {
        self.searchImage.change(type: .init(rawValue: type)!)
        
        if self.state == .searched {
            self.search(query: query)
        }
    }
}

// MARK: - 이미지 검색
extension SearchViewModel {
    func search(query: String) {
        guard query.isEmpty == false else { return }
        self.updateHistory(query: query)
        self.searchImage.search(query: query) { data in
            self.gifs = data.images
            self.state = .searched
        } failure: { error in
            switch error {
            case UseCaseError.Others.empty:
                self.state = .initialized
            default: break
            }
        }
    }
    
    func page() {
        self.searchImage.page { data in
            self.gifs.append(contentsOf: data.images)
        } failure: { _ in
            
        }
    }
}
// MARK: - 트렌딩 검색어
extension SearchViewModel {
    func readTrendingTerms() {
        self.searchTrendingTerms.search { terms in
            self.trending[0] = terms
        }
    }
}
// MARK: - 검색 기록
extension SearchViewModel {
    func readHistory() {
        self.trending[1] = (try? self.searchHistory.read()) ?? []
    }
    
    func updateHistory(query: String) {
        self.searchHistory.update(query: query)
    }
}

extension SearchViewModel {
    enum SearchViewState {
        /// 입력 필드가 활성화 되지 않았으며, 검색 동작도 취해지지 않음
        case initialized
        /// 입력 필드가 활성화 되었지만, 아직 입력을 받지 않음
        case waitingQuery
        /// 입력 필드가 활성화 되었으며 하나 이상의 입력을 받음
        case waitingSearch
        /// 입력 필드가 활성화 되지 않았으며, 검색 동작이 취해짐
        case searched
    }
}

private extension SearchViewModel {
    func stateDidChange(to state: SearchViewState) {
        switch state {
        case .searched:
            self.openSearchAssistant.send(false)
            return
        case .initialized, .waitingQuery:
            self.readTrendingTerms()
            self.readHistory()
        default: break
        }
        
        self.gifs.removeAll()
        self.openSearchAssistant.send(true)
    }
}
