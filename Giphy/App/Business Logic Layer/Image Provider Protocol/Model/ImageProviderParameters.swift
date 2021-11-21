//
//  ImageProviderParameters.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct ImageProviderParameters {
    struct Search {
        var query: String
        var size: Int
        var page: Int
        var type: Int
    }
}
