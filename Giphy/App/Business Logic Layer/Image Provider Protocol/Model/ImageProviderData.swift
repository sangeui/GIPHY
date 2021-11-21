//
//  ImageProviderData.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/20.
//

import Foundation

struct ImageProviderData {
    var images: [ImageProviderImage]
}

struct ImageProviderImage {
    var thumbnail: String = ""
    var original: String = ""
    var width: Int = 0
    var height: Int = 0
    
    var user: User?
    var isAvailableUserProfile: Bool = false
    var uniqueID: String = ""
}

extension ImageProviderImage {
    struct User {
        var primaryName: String
        var secondaryName: String
        var avatarURL: String
    }
}
