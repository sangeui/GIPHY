//
//  GiphySearchGIF.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct GiphyGIF: Decodable {
    var type: String? = ""
    var id: String? = ""
    var slug: String? = ""
    var url: String? = ""
    var bitlyURL: String? = ""
    var embedURL: String? = ""
    var username: String? = ""
    var source: String? = ""
    var rating: String? = ""
    var contentURL: String? = ""
    var user: GiphyUser?
    var sourceTLD: String? = ""
    var sourcePostURL: String? = ""
    var updateDateTime: String? = ""
    var createDateTime: String? = ""
    var importDateTime: String? = ""
    var trendingDateTime: String? = ""
    var images: GiphyImages?
    var title: String? = ""
}

extension GiphyGIF {
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case slug
        case url
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username
        case source
        case rating
        case contentURL = "content_url"
        case user
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case updateDateTime = "update_datetime"
        case createDateTime = "create_datetime"
        case importDateTime = "import_datetime"
        case trendingDateTime = "trending_datetime"
        case images
        case title
    }
}
