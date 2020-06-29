//
//  Network Layer.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 5.08.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class NetworkLayer {
    static let genericError = "Something went wrong. Please try again later"
    func get<FoursquareResponseModel: Decodable>(urlString: String,
                           headers: [String: String] = [:],
                           successHandler: @escaping (FoursquareResponseModel) -> Void,
                           errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(NetworkLayer.genericError)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(FoursquareResponseModel.self)")
                    return errorHandler(NetworkLayer.genericError)
                }
                if let responseObject = try? JSONDecoder().decode(FoursquareResponseModel.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }
            errorHandler(NetworkLayer.genericError)
        }
        
        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request,
                                   completionHandler: completionHandler)
            .resume()
    }

        private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
        private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}

