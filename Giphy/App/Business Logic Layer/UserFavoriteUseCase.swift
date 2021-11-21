//
//  UserDataUseCase.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import Foundation

class UserFavoriteUseCase {
    private let storage: FavoriteStorageProtocol
    
    init(storage: FavoriteStorageProtocol) {
        self.storage = storage
    }
    
    func update(key: String, favorite: Bool) {
        try? self.storage.save(key: key, bool: favorite)
    }
    
    func read(key: String) throws -> Bool {
        return (try? self.storage.read(key: key)) ?? false
    }
}
