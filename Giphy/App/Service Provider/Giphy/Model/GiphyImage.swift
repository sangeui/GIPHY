//
//  GiphyImage.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct GiphyImage: Decodable {
    var url: String? = ""
    var width: String? = ""
    var height: String? = ""
    var frames: String? = ""
    var size: String? = ""
    var mp4: String? = ""
    var mp4Size: String? = ""
    var webp: String? = ""
    var webpSize: String? = ""
}

extension GiphyImage {
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
        case frames
        case size
        case mp4
        case mp4Size = "mp4_size"
        case webp
        case webpSize = "webp_size"
    }
}
