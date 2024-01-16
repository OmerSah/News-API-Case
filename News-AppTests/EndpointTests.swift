//
//  EndpointTests.swift
//  News-AppTests
//
//  Created by Ömer Faruk Şahin on 11.08.2022.
//
import XCTest
@testable import News_App

class EndpointTests: XCTestCase {

    var newsRequestFetchEverything: NewsRequest?
    var newsRequestTopHeadlines: NewsRequest?
    var newsRequestSearch: NewsRequest?
    var newsRequestDates: NewsRequest?
    
    override func setUp() {
        super.setUp()
        
        let page = 1
        let from = "2022-07-10"
        let to = "2022-08-09"
        let query = "q"
        
        newsRequestFetchEverything = NewsRequest.fetchEverything(page)
        newsRequestTopHeadlines = NewsRequest.fetchTopHeadlines(page)
        newsRequestSearch = NewsRequest.fetchSearchData(query, page, from, to)
        newsRequestDates = NewsRequest.fetchNewsOfSpecifiedDates(page, from, to)
    }

    override func tearDown() {
        newsRequestFetchEverything = nil
        newsRequestTopHeadlines = nil
        newsRequestSearch = nil
        newsRequestDates = nil
        super.tearDown()
    }
    
    func testEndpoints() throws {
        XCTAssertEqual(
            newsRequestFetchEverything?.createURLWithoutParameters(),
            "https://newsapi.org/v2/everything"
        )
        XCTAssertEqual(
            newsRequestTopHeadlines?.createURLWithoutParameters(),
            "https://newsapi.org/v2/top-headlines"
        )
        XCTAssertEqual(
            newsRequestSearch?.createURLWithoutParameters(),
            "https://newsapi.org/v2/everything"
        )
        XCTAssertEqual(
            newsRequestDates?.createURLWithoutParameters(),
            "https://newsapi.org/v2/top-headlines"
        )
    }

}
