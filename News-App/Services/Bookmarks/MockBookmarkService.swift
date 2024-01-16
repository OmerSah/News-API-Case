//
//  MockBookmarkService.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 11.08.2022.
//

import Foundation

class MockBookmarkService: BookmarkServiceProtocol {
    
    var isGetBookmarkedNewsCalled = false
    var isSetBookmarkedNewsCalled = false
    var isUpdateBookmarkedNewsCalled = false
    
    
    func getBookmarkedNews() -> [Article] {
        isGetBookmarkedNewsCalled = true
        return []
    }
    
    func setBookmarkedNews(with news: [Article]) {
        isSetBookmarkedNewsCalled = true
    }
    
    func updateBookmarkedNews(in news: [Article]) -> [Article] {
        isUpdateBookmarkedNewsCalled = true
        return []
    }
    
}
