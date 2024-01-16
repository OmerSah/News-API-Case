//
//  Input+Output+NewsList.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 17.07.2022.
//

import Foundation

protocol NewsListInput: AnyObject {
    func viewWillAppear()
}

protocol NewsListOutput: AnyObject {
    func refresh()
    func showError(error: NetworkError)
    func endTableRefresh()
}
