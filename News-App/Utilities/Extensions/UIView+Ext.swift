//
//  File.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import UIKit
import SnapKit

extension UIView {
    func pin(to view: UIView) {
        self.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
}
    
