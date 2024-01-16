//
//  Response.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 12.07.2022.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}
