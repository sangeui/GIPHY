//
//  SearchTrendingTermsUseCase.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import Foundation

class SearchTrendingUseCase {
    private let trendingTermsProvider: TrendingTermsProviderProtocol = GiphyImageProvider()
    private let numberOfResultsToReturn = 5
    
    func search(success: @escaping ([String]) -> Void) {
        self.trendingTermsProvider.search() { terms in
            success(self.slice(terms))
        } failure: { _ in }
    }
}

private extension SearchTrendingUseCase {
    func slice(_ array: [String]) -> [String] {
        return Array(array[0..<min(array.count, self.numberOfResultsToReturn)])
    }
}
