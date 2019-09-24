//
//  NewsapiImplementTests.swift
//  NewsapiImplementTests
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import XCTest
@testable import NewsapiImplement

class NewsapiImplementTests: XCTestCase {

    override func setUp() {
        ConfigService.shared.store("us", for: .country)
        ConfigService.shared.store("bitcoin", for: .keyword)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTopHeadlineAPI() {
        
        let expectation = XCTestExpectation(description: "Wait for loading data")
        let timeToWait = TimeInterval(30)
        
        let country = ConfigService.shared.stored(for: .country)!
        NewsService().topHeadline(NewsService.NewsRequest(query: country, totalNews: 0, currentPage: 1)) {
            news, status, code, message in
            log.debug(news)
            log.debug(status)
            log.debug(code)
            log.debug(message)
            
            XCTAssertNotNil(news, "Cannot load top headline")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: timeToWait)
    }
    
    func testCustomAPI() {
        
        let expectation = XCTestExpectation(description: "Wait for loading data")
        let timeToWait = TimeInterval(30)
        
        let keyword = ConfigService.shared.stored(for: .keyword)!
        NewsService().customSearch(NewsService.NewsRequest(query: keyword, totalNews: 0, currentPage: 1)) {
            news, status, code, message in
            log.debug(news)
            log.debug(status)
            log.debug(code)
            log.debug(message)
            
            XCTAssertNotNil(news, message ?? "Cannot load top headline")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: timeToWait)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
