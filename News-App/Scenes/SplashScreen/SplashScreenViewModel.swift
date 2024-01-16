//
//  SplashScreenViewModel.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 13.07.2022.
//

import Foundation
import UserNotifications

final class SplashScreenViewModel {
    weak var input: SplashScreenInput?
    weak var output: SplashScreenOutput?

    
    private let newsService = NewsService()
    private let bookmarkService = BookmarkService()
    private let appManager = AppManager.shared
    
    init() { input = self }
    
    func requestForNotification() {
      
    }
}

extension SplashScreenViewModel: SplashScreenInput {
    
    func viewDidLoad() {
        let q1 = DispatchQueue(label: "Notification")
        let q2 = DispatchQueue(label: "Fetch")
        let group = DispatchGroup()
        
        q1.async(group: group) {
            UNUserNotificationCenter.current()
              .requestAuthorization(options: [.alert, .sound, .badge]) { authorized, error  in
                  print("Granted: \(authorized)")
              }
        }
        
        q2.async(group: group) { [weak self] in
            guard let self = self else { return }
            self.newsService.fetchTopHeadlines(1) { result in
                switch result {
                case .success(let response):
                    AppManager.shared.news = response.articles
                case .failure(let error):
                    self.output?.showError(error: error)
                }
            }
        }

        group.notify(queue: DispatchQueue.main) {
            self.output?.createTabBar()
        }
    }
    
}
