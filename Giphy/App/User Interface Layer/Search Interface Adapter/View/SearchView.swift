//
//  SearchView.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import UIKit
import Combine

class SearchView: UIView {
    // MARK: - View Model
    private let viewModel: SearchViewModel
    
    private var anyCancellableSet = Set<AnyCancellable>()
    
    private let searchHeaderView: SearchHeaderView = .init()
    private let searchResultView: SearchResultView = .init()
    private let searchTrendingView: SearchTrendingView = .init()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Reactive
private extension SearchView {
    func bindToUpdatedGIFs() {
        self.viewModel.$gifs.eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { data in
                self.searchResultView.data = data
            }
            .store(in: &self.anyCancellableSet)
    }
    
    func bindToUpdatedTrendings() {
        self.viewModel.$trending.eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { trendings in
                self.searchTrendingView.source = trendings
            }
            .store(in: &self.anyCancellableSet)
    }
    
    func bindToState() {
        self.viewModel.$state.eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink { state in
                self.searchTrendingView.isHidden = [.initialized, .waitingQuery].contains(state) == false
            }
            .store(in: &self.anyCancellableSet)
    }
}

private extension SearchView {
    func setup() {
        self.backgroundColor = .systemBackground
        self.setupSearchHeaderView(self.searchHeaderView)
        self.setupCollectionView(self.searchResultView)
        self.setupSearchTrendingView(self.searchTrendingView)
        
        self.bindToUpdatedGIFs()
        self.bindToUpdatedTrendings()
        self.bindToState()
    }
    
    func setupSearchHeaderView(_ view: SearchHeaderView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.onDidBeginSearch = { [weak self] text in
            self?.viewModel.userDidChangeSearchViewState(text: text, isInputActive: true)
        }
        
        view.onDidChangeSearchQuery = { [weak self] text in
            self?.viewModel.userDidChangeSearchViewState(text: text, isInputActive: true)
        }
        
        view.onSearchButtonClicked = { [weak self] text in
            self?.viewModel.search(query: text)
            self?.searchResultView.setContentOffset(.zero, animated: true)
        }
        
        view.onDidChangeSegmentedValue = { [weak self] query, index in
            self?.viewModel.userDidChangeSearchType(to: index, query: query)
        }
    }
    
    func setupCollectionView(_ collectionView: SearchResultView) {
        self.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.searchHeaderView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.onTouchItemAt = { [weak self] index in
            self?.viewModel.userDidTouchItem(at: index)
        }
        
        collectionView.onReachedScrollBottom = { [weak self] in
            self?.viewModel.page()
        }
    }
    
    func setupSearchTrendingView(_ view: SearchTrendingView) {
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.searchHeaderView.bottomAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.onTouchTrendingTerm = { [weak self] term in
            guard let self = self else { return }
            self.searchHeaderView.searchQuery = term
            self.viewModel.userDidChangeSearchViewState(text: term, isInputActive: true)
            self.viewModel.search(query: term)
            self.endEditing(true)
        }
        
        view.onTouchHistoryQuery = { [weak self] query in
            guard let self = self else { return }
            self.searchHeaderView.searchQuery = query
            self.viewModel.userDidChangeSearchViewState(text: query, isInputActive: true)
            self.viewModel.search(query: query)
            self.endEditing(true)
        }
    }
}
