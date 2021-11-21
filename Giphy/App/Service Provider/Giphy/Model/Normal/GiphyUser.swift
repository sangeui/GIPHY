//
//  GiphyUser.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import Foundation

struct GiphyUser: Decodable {
    var avatarURL: String?
    var bannerURL: String?
    var profileURL: String?
    var userName: String?
    var displayName: String?
}

extension GiphyUser {
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case userName = "username"
        case displayName = "display_name"
    }
}
