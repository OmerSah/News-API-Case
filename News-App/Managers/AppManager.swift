//
//  AppManager.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 13.07.2022.
//

import Foundation

class AppManager {
    static let shared = AppManager()
    
    var news = [Article]()

    private init() { }
}
