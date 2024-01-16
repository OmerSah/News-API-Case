//
//  DateFormatter+Ext.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 12.07.2022.
//

import Foundation

extension DateFormatter {
    
    static let newsAPIResponseDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter
    }()
    
    static let filterDateFormat: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}
