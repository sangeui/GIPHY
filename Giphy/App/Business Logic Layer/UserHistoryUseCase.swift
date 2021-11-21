//
//  UserHistoryUseCase.swift
//  Giphy
//
//  Created by 서상의 on 2021/11/21.
//

import Foundation

class UserHistoryUseCase {
    private let storage: HistoryStorageProtocol
    
    init(storage: HistoryStorageProtocol) {
        self.storage = storage
    }
    
    func update(query: String) {
        try? self.storage.save(query: query)
    }
    
    func read() throws -> [String] {
        return (try? self.storage.read()) ?? []
    }
}

protocol HistoryStorageProtocol {
    func save(query: String) throws
    func read() throws -> [String]
}
