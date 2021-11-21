//
//  TrendingTermsProviderProtocol.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import Foundation

protocol TrendingTermsProviderProtocol {
    typealias Success = ([String]) -> Void
    typealias Failure = (Error) -> Void
    
    func search(success: @escaping Success, failure: @escaping Failure)
}
