//
//  GiphyPagination.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct GiphyPagination: Decodable {
    var offset: Int?
    var totalCount: Int?
    var count: Int?
}

extension GiphyPagination {
    enum CodingKeys: String, CodingKey {
        case offset
        case totalCount = "total_count"
        case count
    }
}
