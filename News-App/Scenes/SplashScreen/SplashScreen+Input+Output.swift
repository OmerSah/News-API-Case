//
//  Input+Output+SplashScreen.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 13.07.2022.
//

import Foundation

protocol SplashScreenInput: AnyObject {
    func viewDidLoad()
}

protocol SplashScreenOutput: AnyObject {
    func createTabBar()
    func showError(error: NetworkError)
}
