//
//  FilterViewController.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 10.08.2022.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    private lazy var fromDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = .current
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.minimumDate = DateFormatter.filterDateFormat.date(from: "2022-07-10")
        picker.maximumDate = DateFormatter.filterDateFormat.date(from: "2022-08-09")
        return picker
    }()
    
    private let toDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.locale = .current
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.minimumDate = DateFormatter.filterDateFormat.date(from: "2022-07-09")
        picker.maximumDate = DateFormatter.filterDateFormat.date(from: "2022-08-09")
        return picker
    }()
    
    private let fromLabel: UILabel = .init(text: "FILTER_FROM_TITLE".localized,
                                           font: .boldSystemFont(ofSize: 16), textColor: .lightGray)
    
    private let toLabel: UILabel = .init(text: "FILTER_TO_TITLE".localized,
                                         font: .boldSystemFont(ofSize: 16), textColor: .lightGray)
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.setTitle("FILTER_BUTTON_TITLE".localized, for: .normal)
        button.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        return button
    }()
    
    var filterButtonAction: ((_ from: String, _ to: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure()
    }
    
    private func configure() {
        view.addSubview(fromLabel)
        view.addSubview(toLabel)
        view.addSubview(fromDatePicker)
        view.addSubview(toDatePicker)
        view.addSubview(filterButton)
        
        view.backgroundColor = .white
        
        makeAllConstraints()
    }
    
    private func makeAllConstraints() {
        
        fromLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            $0.leading.equalTo(32)
        }
        
        fromDatePicker.snp.makeConstraints {
            $0.top.equalTo(fromLabel.snp.bottom).offset(12)
            $0.leading.equalTo(32)
        }
        
        toLabel.snp.makeConstraints {
            $0.top.equalTo(fromDatePicker.snp.bottom).offset(16)
            $0.leading.equalTo(32)
        }
        
        toDatePicker.snp.makeConstraints {
            $0.top.equalTo(toLabel.snp.bottom).offset(12)
            $0.leading.equalTo(32)
        }
        
        filterButton.snp.makeConstraints {
            $0.top.equalTo(toDatePicker.snp.bottom).offset(28)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(200)
        }
        
    }
    
    @objc func filterAction() {
        filterButtonAction?(
            DateFormatter.filterDateFormat.string(from: fromDatePicker.date),
            DateFormatter.filterDateFormat.string(from: toDatePicker.date)
        )
        self.dismiss(animated: true)
    }
}
