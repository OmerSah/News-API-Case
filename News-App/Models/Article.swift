//
//  News.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import Foundation

struct Article: Codable {
    let source: NewsSource
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    var isBookmarked = false
    
    enum CodingKeys: CodingKey {
       case source, author, title, description,
            url, urlToImage, publishedAt, content
    }
}

