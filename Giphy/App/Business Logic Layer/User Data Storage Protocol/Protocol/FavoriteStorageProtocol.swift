//
//  UserDataStorageProtocol.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import Foundation

protocol FavoriteStorageProtocol {
    func save(key: String, bool: Bool) throws
    func read(key: String) throws -> Bool
}
