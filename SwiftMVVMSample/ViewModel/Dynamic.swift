//
//  Dynamic.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    var bind :(T) -> () = { _ in }
    
    var value :T? {
        didSet {
            bind(value!)
        }
    }
    
    init(_ v :T) {
        value = v
    }
}
