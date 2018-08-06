//
//  APIManager.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation

class APIManager {
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    func getData<T>(urlPath: String, completionHandler: @escaping (ResponeStatus<T>) -> Void) {
        
        dataTask?.cancel()
        
        var request = URLRequest(url: URL(string: urlPath)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "GET"
        
        dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
            defer { self.dataTask = nil }
            
            if let error = error {
                completionHandler(ResponeStatus.failure(errorType: ErrorType.service, message: error.localizedDescription))
                
            } else if let data = data {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(T.self, from: data)
                        completionHandler(ResponeStatus.success(data: result))
                    } catch let error {
                        completionHandler(ResponeStatus.failure(errorType: ErrorType.api(statusCode: response.statusCode), message: error.localizedDescription))
                    }
                }
            } else {
                if let response = response as? HTTPURLResponse {
                    completionHandler(ResponeStatus.failure(errorType: ErrorType.api(statusCode: response.statusCode), message: "ERROR: Server Error"))
                }
            }
        }
        dataTask?.resume()
    }
}
