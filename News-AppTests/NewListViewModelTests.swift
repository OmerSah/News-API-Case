//
//  NewListViewModelTests.swift
//  News-AppTests
//
//  Created by Ömer Faruk Şahin on 11.08.2022.
//

import XCTest
@testable import News_App

class NewListViewModelTests: XCTestCase {

    var sut: NewsListViewModel!
    var mockNewsService: MockNewsService!
    var mockBookmarkService: MockBookmarkService!
    
    override func setUp() {
        super.setUp()
        mockNewsService = MockNewsService()
        mockBookmarkService = MockBookmarkService()
        sut = NewsListViewModel(mockNewsService, mockBookmarkService)
    }
    
    override func tearDown() {
        sut = nil
        mockNewsService = nil
        super.tearDown()
    }
    
    func testFetchNews() throws {
        sut.fetchNews()
        XCTAssert(mockNewsService.isFetchTopHeadlinesCalled)
    }
    
    func testFetchRange() throws {
        sut.filterNewsByRange(from: "", to: "")
        XCTAssert(mockNewsService.isfetchNewsOfSpecifiedDatesCalled)
    }
    
    func testSearchData() throws {
        sut.searchNews(query: "Search")
        XCTAssert(mockNewsService.isFetchSearchDataCalled)
    }
    
    func testBookmarkUpdate() throws {
        sut.viewWillAppear()
        XCTAssert(mockBookmarkService.isUpdateBookmarkedNewsCalled)
    }
    
    func testBookmarkGetSet() throws {
        let article = Article(source: NewsSource(id: "", name: ""),
                              author: "", title: "", description: "",
                              url: "", urlToImage: "", publishedAt: Date(), content: "")
        
        sut.bookmarkButtonAction(article: article)
        
        XCTAssert(mockBookmarkService.isGetBookmarkedNewsCalled)
        XCTAssert(mockBookmarkService.isSetBookmarkedNewsCalled)
    }
    

}
