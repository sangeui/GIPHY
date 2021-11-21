//
//  FavoriteLocalStorage.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import Foundation

class LocalStorage: FavoriteStorageProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func save(key: String, bool: Bool) throws {
        self.userDefaults.set(bool, forKey: key)
    }
    
    func read(key: String) throws -> Bool {
        self.userDefaults.bool(forKey: key)
    }
}

extension LocalStorage: HistoryStorageProtocol {
    func save(query: String) throws {
        var history = (try? self.read()) ?? []
        history.removeAll(where: { $0 == query })
        history.insert(query, at: .zero)
        self.userDefaults.set(history, forKey: "History")
    }
    
    func read() throws -> [String] {
        self.userDefaults.value(forKey: "History") as? [String] ?? []
    }
}
