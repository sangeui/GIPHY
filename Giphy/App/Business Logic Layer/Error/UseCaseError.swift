//
//  ImageProviderError.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

enum UseCaseError: Error {
    enum Client: Error {
        case badURL
        case badRequest
        case forbidden
        case notFound
        case tooManyRequests
    }
    
    enum Server: Error {
        case unknown
    }
    
    enum Network: Error {
        case timeout
        case unknown
    }
    
    enum Others: Error {
        case empty
        case decoding
        case unknown
    }
}
