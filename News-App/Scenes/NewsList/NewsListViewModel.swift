//
//  NewsListViewModel.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import Foundation

final class NewsListViewModel {
    private(set) var news = [Article]()
    
    weak var input: NewsListInput?
    weak var output: NewsListOutput?
    
    private let newsService: NewsServiceProtocol
    private let bookmarkService: BookmarkServiceProtocol
    private let appManager = AppManager.shared
    
    var queryForDateRange = ""
    
    init(_ newsService: NewsServiceProtocol,
         _ bookmarkService: BookmarkServiceProtocol) {
        
        self.bookmarkService = bookmarkService
        self.newsService = newsService
        
        input = self
        
        news = AppManager.shared.news
        if news.isEmpty { fetchNews() }
    }
    
    func bookmarkButtonAction(article: Article) {
        var bookmarked = bookmarkService.getBookmarkedNews()
        
        if !article.isBookmarked  {
            if !bookmarked.contains(where: { $0.title == article.title } ) {
                bookmarked.append(article)
            }
        } else {
            bookmarked = bookmarked.filter( { $0.title != article.title } )
        }
        
        bookmarkService.setBookmarkedNews(with: bookmarked)
        news = bookmarkService.updateBookmarkedNews(in: news)
        output?.refresh()
    }
    
    func fetchNews() {
        newsService.fetchTopHeadlines(1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.news = response.articles
                    self.news = self.bookmarkService.updateBookmarkedNews(in: self.news)
                    self.output?.refresh()
                }
            case .failure(let error):
                self.output?.showError(error: error)
            }
        }
    }
    
    func refreshData(filterStaus: Bool) {
        guard filterStaus == false,
              queryForDateRange == ""
        else { return }
        
        newsService.fetchTopHeadlines(1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.news = response.articles
                    self.news = self.bookmarkService.updateBookmarkedNews(in: self.news)
                    self.output?.refresh()
                    self.output?.endTableRefresh()
                }
            case .failure(let error):
                self.output?.showError(error: error)
            }
        }
    }
    
    func searchNews(query: String) {
        let completion: (Result<NewsResponse,NetworkError>) -> () = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.news = response.articles
                    self.news = self.bookmarkService.updateBookmarkedNews(in: self.news)
                    self.output?.refresh()
                }
            case .failure(let error):
                self.output?.showError(error: error)
            }
        }
        
        guard query != "" else {
            newsService.fetchTopHeadlines(1, completion: completion)
            return
        }
        newsService.fetchSearchData(query, 1, "", "", completion: completion)
    }
    
    func filterNewsByRange(from: String, to: String) {
        
        let completion: (Result<NewsResponse,NetworkError>) -> () = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.news = response.articles
                    self.news = self.bookmarkService.updateBookmarkedNews(in: self.news)
                    self.output?.refresh()
                }
            case .failure(let error):
                self.output?.showError(error: error)
            }
        }
        
        guard queryForDateRange == "" else {
            newsService.fetchSearchData(queryForDateRange, 1, from, to, completion: completion)
            return
        }
        newsService.fetchNewsOfSpecifiedDates(1, from, to, completion: completion)
    }
    
}

extension NewsListViewModel: NewsListInput {
    func viewWillAppear() {
        news = bookmarkService.updateBookmarkedNews(in: news)
        output?.refresh()
    }
}
