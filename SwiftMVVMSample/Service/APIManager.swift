//
//  APIManager.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static func getData<T>(urlPath: String, completionHandler: @escaping (ResponeStatus<T>) -> Void) {
        
        var request = URLRequest(url: URL(string: urlPath)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (resultData, response, error) in
            
            if error != nil {
                completionHandler(ResponeStatus.failure(errorType: ErrorType.service, message: error?.localizedDescription ?? "ERROR: Not Connected To Internet"))
            } else {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    if statusCode != 200 {
                        completionHandler(ResponeStatus.failure(errorType: ErrorType.api(statusCode: statusCode), message: "ERROR: Server Error"))
                    } else {
                        if let data = resultData {
                            do {
                                let jsonDecoder = JSONDecoder()
                                let result = try jsonDecoder.decode(T.self, from: data)
                                completionHandler(ResponeStatus.success(data: result))
                            } catch let error {
                                completionHandler(ResponeStatus.failure(errorType: ErrorType.api(statusCode: statusCode), message: error.localizedDescription))
                            }
                        } else {
                            completionHandler(ResponeStatus.failure(errorType: ErrorType.api(statusCode: statusCode), message: "ERROR: Data is empty"))
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
}
