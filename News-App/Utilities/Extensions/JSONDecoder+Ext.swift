//
//  JSONDecoder+Ext.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 12.07.2022.
//

import Foundation

extension JSONDecoder {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.newsAPIResponseDateFormat)
        return jsonDecoder
    }()
}
