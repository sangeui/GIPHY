//
//  SearchImageProtocol.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

protocol ImageProviderProtocol {
    typealias Success = (ImageProviderData) -> Void
    typealias Failure = (Error) -> Void
    
    func search(parameters: ImageProviderParameters.Search, success: @escaping Success, failure: @escaping Failure)
}
