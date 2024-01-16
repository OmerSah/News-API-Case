//
//  String+Ext.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 11.08.2022.
//

import Foundation

extension String {
    var localized: String {
       NSLocalizedString(self, comment: "")
    }
}
