//
//  NewsService.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 12.07.2022.
//

import Foundation
import Alamofire

protocol NewsServiceProtocol {
    typealias Completion = (Result<NewsResponse, NetworkError>) -> ()
    func fetchSearchData(_ query: String, _ page: Int, _ from: String, _ to: String,
                         completion: @escaping Completion)
    func fetchTopHeadlines(_ page: Int, completion: @escaping Completion)
    func fetchEverything(_ page: Int, completion: @escaping Completion)
    func fetchNewsOfSpecifiedDates(_ page: Int, _ from: String, _ to: String, completion: @escaping Completion)
}

class NewsService: NewsServiceProtocol {
    
    private let s = ServiceManager.shared

    func fetchTopHeadlines(_ page: Int, completion: @escaping Completion) {
        s.request(NewsRequest.fetchTopHeadlines(page).createURLRequest(), completion: completion)
    }
    
    func fetchSearchData(_ query: String, _ page: Int, _ from: String, _ to: String,
                         completion: @escaping Completion) {
        s.request(NewsRequest.fetchSearchData(query, page, from, to).createURLRequest(), completion: completion)
    }
    
    func fetchEverything(_ page: Int, completion: @escaping Completion) {
        s.request(NewsRequest.fetchEverything(page).createURLRequest(), completion: completion)
    }
    
    func fetchNewsOfSpecifiedDates(_ page: Int, _ from: String, _ to: String, completion: @escaping Completion) {
        s.request(NewsRequest.fetchNewsOfSpecifiedDates(page, from, to).createURLRequest(),
                  completion: completion)
    }
    
}
