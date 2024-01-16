//
//  MockNewsService.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 11.08.2022.
//

import Foundation

class MockNewsService: NewsServiceProtocol {
    var completeClosure: Completion!
    
    var isFetchSearchDataCalled = false
    var isFetchTopHeadlinesCalled = false
    var isFetchEverythingCalled = false
    var isfetchNewsOfSpecifiedDatesCalled = false
    
    func fetchSearchData(_ query: String, _ page: Int, _ from: String, _ to: String, completion: @escaping Completion) {
        isFetchSearchDataCalled = true
        completeClosure = completion
    }
    
    func fetchTopHeadlines(_ page: Int, completion: @escaping Completion) {
        isFetchTopHeadlinesCalled = true
        completeClosure = completion
    }
    
    func fetchEverything(_ page: Int, completion: @escaping Completion) {
        isFetchEverythingCalled = true
        completeClosure = completion
    }
    
    func fetchNewsOfSpecifiedDates(_ page: Int, _ from: String, _ to: String, completion: @escaping Completion) {
        isfetchNewsOfSpecifiedDatesCalled = true
        completeClosure = completion
    }
}
