//
//  NewsAPI.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 5.08.2022.
//

import Foundation

enum NewsRequest {
    case fetchSearchData(_ query: String, _ page: Int, _ from: String, _ to: String)
    case fetchTopHeadlines(_ page: Int)
    case fetchEverything(_ page: Int)
    case fetchNewsOfSpecifiedDates(_ page: Int, _ from: String, _ to: String)
}

extension NewsRequest: APIRequest {
    
    var path: String {
        
        switch self {
        case .fetchSearchData(_, _, _, _):
            return NewsEndpoint.everything.rawValue
        case .fetchEverything(_):
            return NewsEndpoint.everything.rawValue
        case .fetchTopHeadlines(_):
            return NewsEndpoint.topHeadlines.rawValue
        case .fetchNewsOfSpecifiedDates(_, _, _):
            return NewsEndpoint.topHeadlines.rawValue
        }
        
    }
    
    var urlParams: [String : Any] {
        let l = "APP_LANGUAGE".localized
        switch self {
        case .fetchTopHeadlines(let page):
            return ["page" : page, "pageSize": 15, "sortBy": "publishedAt",
                    "language": l, "apiKey": Constants.API.apiKey]
        case .fetchEverything(let page):
            return ["page" : page, "pageSize": 15, "sortBy": "publishedAt",
                    "language": l, "apiKey": Constants.API.apiKey]
        case .fetchSearchData(let query, let page, let from, let to):
            return ["page" : page, "pageSize": 15, "q": query, "sortBy": "publishedAt",
                    "language": l, "apiKey": Constants.API.apiKey, "from": from, "to": to]
        case .fetchNewsOfSpecifiedDates(let page, let from, let to):
            return ["page" : page, "pageSize": 15, "language": l, "sortBy": "publishedAt",
                    "from": from, "to": to, "apiKey": Constants.API.apiKey]
        }
    }
    
}
