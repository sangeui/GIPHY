//
//  GiphyMeta.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct GiphyMeta: Decodable {
    var msg: String
    var status: Int
    var responseID: String?
}

extension GiphyMeta {
    enum CodingKeys: String, CodingKey {
        case msg
        case status
        case responseID = "response_id"
    }
}
