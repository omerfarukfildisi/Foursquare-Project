//
//  Service.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 5.08.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation

enum ServiceMethod: String {
    case post = "POST"
    case get = "GET"
    // implement more when needed: post, put, delete, patch, etc.
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: ServiceMethod { get }
   
}

extension Service {
    public var urlRequest: URLRequest {
        let url = self.url
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        return request
    }
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        if method == .get {
            // add query items to url 
            guard let parameters = parameters as? [String: String] else {
                fatalError("parameters for GET http method must conform to [String: String]")
            }
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        return urlComponents?.url
    }
}
