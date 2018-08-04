//
//  AppConstants.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation

enum ResponeStatus<T: Codable> {
    case success(data: T)
    case failure(errorType: ErrorType, message: String)
}


enum ErrorType {
    case service
    case api(statusCode: Int)
}
