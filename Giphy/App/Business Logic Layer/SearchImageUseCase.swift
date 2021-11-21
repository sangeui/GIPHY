//
//  SearchImageUseCase.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

class SearchImageUseCase {
    typealias Success = (ImageProviderData) -> Void
    typealias Failure = (Error) -> Void
    
    private let imageProvider: ImageProviderProtocol
    private var query = ""
    private let pageSize = 20
    private var page = 0
    private var type: ResultType = .GIFs
    
    init(imageProvider: ImageProviderProtocol) {
        self.imageProvider = imageProvider
    }
    
    func search(query: String, success: @escaping Success, failure: @escaping Failure ) {
        let parameters = ImageProviderParameters.Search(query: query,
                                                        size: self.pageSize,
                                                        page: .zero,
                                                        type: self.type.rawValue)
        
        self.imageProvider.search(parameters: parameters) { data in
            self.query = query
            success(data)
        } failure: { error in
            failure(error)
        }
    }
    
    func page(success: @escaping Success, failure: @escaping Failure) {
        let parameters = ImageProviderParameters.Search(query: self.query,
                                                        size: self.pageSize,
                                                        page: self.page + 1,
                                                        type: self.type.rawValue)
        self.page += 1
        
        self.imageProvider.search(parameters: parameters) { data in
            success(data)
        } failure: { error in
            failure(error)
        }
    }
    
    func change(type to: ResultType) {
        self.type = to
    }
}

extension SearchImageUseCase {
    enum ResultType: Int {
        case GIFs, Stickers
    }
}
