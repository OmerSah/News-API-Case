//
//  SplashScreenViewController.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import UIKit

class SplashScreenViewController: UIViewController {
    private let launchLabel: UILabel = .init(text: "SPLASH_SCREEN_TITLE".localized,
                                             font: UIFont.boldSystemFont(ofSize: 64))
    private let creatorLabel: UILabel = .init(text: Constants.UI.developer,
                                              font: UIFont.systemFont(ofSize: 12), textColor: .lightGray)
    
    private let viewModel = SplashScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.output = self
        
        configure()
        makeAllConstraints()
        
        viewModel.input?.viewDidLoad()
    }
    
    private func configure() {
        view.addSubview(launchLabel)
        view.addSubview(creatorLabel)
    }
    
    private func makeAllConstraints() {
        launchLabel.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
        }
        creatorLabel.snp.makeConstraints {
            $0.top.equalTo(launchLabel.snp.bottom)
            $0.trailing.equalTo(launchLabel.snp.trailing)
        }
    }
}

extension SplashScreenViewController: SplashScreenOutput {
    func createTabBar() {
        let tabBarController = UITabBarController()
        
        let newsList =
        UINavigationController(
            rootViewController: NewsListViewController(
                viewModel: NewsListViewModel(NewsService(), BookmarkService())
            )
        )
        
        let bookmarks =
        UINavigationController(
            rootViewController: BookmarksViewController(
                viewModel: BookmarksViewModel(BookmarkService())
            )
        )
        
        newsList.tabBarItem = UITabBarItem(title: "HOME_TAB_BAR_TITLE".localized,
                                            image: UIImage(systemName: Constants.UI.homeImage),
                                            selectedImage: UIImage(systemName: Constants.UI.selectedHomeImage))
        
        bookmarks.tabBarItem = UITabBarItem(title: "BOOKMARKS_TAB_BAR_TITLE".localized,
                                            image: UIImage(systemName: Constants.UI.bookmarkImage),
                                            selectedImage: UIImage(systemName: Constants.UI.selectedBookmarkImage))

        tabBarController.setViewControllers([newsList, bookmarks], animated: true)
        
        
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.3, options: [.transitionCrossDissolve], animations: {}, completion: nil)
    }
    
    func showError(error: NetworkError) {
        let alert = UIAlertController(title: "Operation Failed!", message: error.localizedDescription,
                                           preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}
