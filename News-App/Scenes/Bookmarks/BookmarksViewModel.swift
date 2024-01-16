//
//  BookmarksViewModel.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 19.07.2022.
//

import Foundation

final class BookmarksViewModel {
    private(set) var news = [Article]()
    
    weak var input: BookmarksInput?
    weak var output: BookmarksOutput?
    
    private let bookmarkService: BookmarkServiceProtocol
    
    init(_ bookmarkService: BookmarkServiceProtocol) {
        self.bookmarkService = bookmarkService
        input = self
    }
    
    func deleteBookmarkedArticle(article: Article) {
        var bookmarked: [Article] = bookmarkService.getBookmarkedNews()
        bookmarked = bookmarked.filter( { $0.title != article.title } )
        bookmarkService.setBookmarkedNews(with: bookmarked)
        news = bookmarkService.getBookmarkedNews()
    }
}

extension BookmarksViewModel: BookmarksInput {
    func viewWillAppear() {
        news = bookmarkService.getBookmarkedNews()
        output?.refresh()
    }
}
