//
//  NewsDetailViewController.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 12.01.2024.
//

import Foundation
import UIKit
import SnapKit
import SafariServices

class NewsDetailViewController: UIViewController {
    
    private let newsTitleLabel: UILabel = .init(font: UIFont.systemFont(ofSize: 24, weight: .heavy), lines: 6)
    private let newsDescriptionLabel: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .lightGray
        textView.isEditable = false
        return textView
    }()
    
    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var sourceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = view.tintColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.setTitle("NEWS_SOURCE".localized, for: .normal)
        button.addTarget(self, action: #selector(sourceButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var bookmarkButton: UIBarButtonItem = {
        let button =
        UIBarButtonItem(
            image: UIImage(systemName: Constants.UI.bookmarkImage),
            style: .plain,
            target: self,
            action: #selector(bookmarkButtonAction)
        )
        return button
    }()
    
    private let authorAndDateView: UIView = UIView()
    
    private let authorView: UIView = UIView()
    
    private let dateView: UIView = UIView()
    
    private let authorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "newspaper")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private let dateImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar.badge.clock")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private let authorLabel: UILabel = .init(font: UIFont.systemFont(ofSize: 12), lines: 3)
    
    private let dateLabel: UILabel = .init(font: UIFont.systemFont(ofSize: 12), lines: 1)
    
    private var news: Article?
    
    var bookmarkAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        navigationItem.title = "DETAIL".localized
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [
            bookmarkButton,
            UIBarButtonItem(
                barButtonSystemItem: .action,
                target: self,
                action: #selector(shareButtonAction)
            )
        ]
        
        configure()
        makeAllConstraints()
    }
    
    private func configure() {
        view.addSubview(newsImage)
        view.addSubview(newsTitleLabel)
        view.addSubview(newsDescriptionLabel)
        view.addSubview(authorAndDateView)
        authorAndDateView.addSubview(authorView)
        authorAndDateView.addSubview(dateView)
        authorView.addSubview(authorImage)
        authorView.addSubview(authorLabel)
        dateView.addSubview(dateImage)
        dateView.addSubview(dateLabel)
        view.addSubview(sourceButton)
    }
    
    private func makeAllConstraints() {
        newsImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(248)
        }
        newsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(newsImage.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        authorAndDateView.snp.makeConstraints {
            $0.top.equalTo(newsTitleLabel.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(72)
        }
        authorView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.leading.equalToSuperview()
        }
        dateView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.trailing.equalToSuperview()
        }
        authorImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(32)
            $0.height.width.equalTo(32)
        }
        dateImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(32)
            $0.height.width.equalTo(32)
        }
        authorLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(authorImage.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(dateImage.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }
        newsDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(authorAndDateView.snp.bottom)
            $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.23)
            $0.width.equalTo(view.safeAreaLayoutGuide).offset(-32)
            $0.centerX.equalToSuperview()
        }
        sourceButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.width.equalTo(view.snp.width).multipliedBy(0.6)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
    
    @objc private func sourceButtonAction() {
        guard let url = URL(string: news?.url ?? "") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    @objc private func bookmarkButtonAction() {
        bookmarkAction?()
        bookmarkButton.isSelected = !bookmarkButton.isSelected
    }
    
    @objc private func shareButtonAction() {
        let sharedURL =  URL(string: news?.url ?? "")
        let ac = UIActivityViewController(activityItems: [sharedURL], applicationActivities: nil)
        present(ac, animated: true)
    }
}

extension NewsDetailViewController {
    func setArticle(article: Article?) {
        guard let article = article else { return }
        self.news = article
        
        newsTitleLabel.text = article.title
        newsDescriptionLabel.text = article.description
        authorLabel.text = article.author ?? "Not Found"
        dateLabel.text = DateFormatter.filterDateFormat.string(from: article.publishedAt)
        bookmarkButton.isSelected = article.isBookmarked
        
        
        newsImage.kf.indicatorType = .activity
        newsImage.kf.setImage(
            with: URL(
                string: article.urlToImage
                ??
                Constants.UI.noImageFoundImageURL
            )
        )
    }
}
