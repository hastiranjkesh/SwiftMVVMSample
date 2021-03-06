//
//  APIManager.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    let imageCache = NSCache<NSString, AnyObject>()
    
    func getDataList<T>(urlPath: String, completionHandler: @escaping (ResponeStatus<T>) -> Void) {
        
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
    
    func downloadImage(path: String, completionHandler: @escaping (Data) -> Void) {
        if let imageUrl = URL(string: path) {
            
            if let cachedImage = imageCache.object(forKey: imageUrl.absoluteString as NSString) {
                completionHandler(cachedImage as! Data)
            } else {
                dataTask = defaultSession.dataTask(with: imageUrl, completionHandler: { data, response, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    if let url = response?.url {
                        self.imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                    }
                    completionHandler(data)
                })
                dataTask?.resume()
            }
        }
    }
}
