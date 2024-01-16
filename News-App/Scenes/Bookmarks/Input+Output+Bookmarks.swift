//
//  Input+Output+Bookmarks.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 19.07.2022.
//

import Foundation

protocol BookmarksInput: AnyObject {
    func viewWillAppear()
}

protocol BookmarksOutput: AnyObject {
    func refresh()
}
