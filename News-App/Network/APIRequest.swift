//
//  APIRequest.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 28.07.2022.
//

import Foundation

enum HTTPMethod: String {
  case GET
  case POST
}

protocol APIRequest {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    
    var urlParams: [String: Any] { get }
    
    var requestType: HTTPMethod { get }
}

extension APIRequest {
    
    var host: String {
        Constants.API.host
    }
    
    var scheme: String {
        "https"
    }

    var requestType: HTTPMethod {
        .GET
    }
    
    var urlParams: [String: Any] {
        [:]
    }
    
    func createURLWithoutParameters() -> String {
        "\(scheme)://\(host)\(path)"
    }
    
    func createURLRequest() -> URLRequest? {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
        }
        
        guard let url = components.url
        else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        return urlRequest
    }
}
