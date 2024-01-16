//
//  BookmarkService.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 13.07.2022.
//

import Foundation

protocol BookmarkServiceProtocol {
    func getBookmarkedNews() -> [Article]
    func setBookmarkedNews(with news: [Article])
    func updateBookmarkedNews(in news: [Article]) -> [Article]
}


class BookmarkService: BookmarkServiceProtocol {
    
    private let key = Constants.UserDefaults.bookmarksKey
    
    func getBookmarkedNews() -> [Article] {
        return UserDefaultsManager.shared.get(key: key)
    }
    
    func setBookmarkedNews(with news: [Article]) {
        UserDefaultsManager.shared.set(items: news, key: key)
    }
    
    func updateBookmarkedNews(in news: [Article]) -> [Article] {
        let bookmarked = getBookmarkedNews()
        
        var modifiedNews = news
        
        for i in 0..<news.count {
            modifiedNews[i].isBookmarked = false
        }
        
        for news in bookmarked {
            for i in 0..<modifiedNews.count {
                if modifiedNews[i].title == news.title {
                    modifiedNews[i].isBookmarked = true
                }
            }
        }
        
        return modifiedNews
    }
    
}
