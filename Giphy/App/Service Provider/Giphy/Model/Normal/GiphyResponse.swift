//
//  GiphySearchResponse.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct GiphyResponse<T: Decodable>: Decodable {
    var data: T
    var pagination: GiphyPagination?
    var meta: GiphyMeta
}
