//
//  NewsEndpoint.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 12.07.2022.
//

import Foundation

enum NewsEndpoint: String, CaseIterable {
    case topHeadlines = "/v2/top-headlines"
    case everything = "/v2/everything"
    case sources = "/v2/top-headlines/sources"
}
