//
//  ServiceManager.swift
//  News-App
//
//  Created by Ömer Faruk Şahin on 8.07.2022.
//

import Foundation
import Alamofire

class ServiceManager {
    static let shared = ServiceManager()
    
    typealias Completion<T: Codable> = (Result<T,NetworkError>) -> ()
    
    private init() { }
    
    func request<T: Codable> (_ urlRequest: URLRequestConvertible?, completion: @escaping Completion<T>) {
        
        guard let request = urlRequest else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        AF.request(request)
            .validate()
            .responseDecodable(of: T.self, decoder: JSONDecoder.jsonDecoder) { (response) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    print(error)
                    completion(.failure(NetworkError.invalidResponse))
                }
            }
    }
    
}
