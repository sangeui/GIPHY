//
//  GiphyTests.swift
//  GiphyTests
//
//  Created by 서상의 on 2021/11/20.
//

import XCTest
@testable import Giphy

class GiphyTests: XCTestCase {
    private var sut: ImageProviderProtocol!
    
    override func setUp() {
        self.sut = GiphyImageProvider()
    }
    
    func test() {
        let expectation = XCTestExpectation(description: "API TEST")
//        wait(for: [expectation], timeout: 5)
        self.sut.search(parameters: .init(query: "TEST", size: 10, page: 0)) { _ in
            expectation.fulfill()
        } failure: { error in
            expectation.fulfill()
        }
    }
}
