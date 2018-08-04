//
//  Service.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation

protocol BaseService {
    func getMusicVideoList(completion:@escaping (ResponeStatus<MusicVideoList>) -> Void)
}

class NetworkRepository: BaseService {
    
    func getMusicVideoList(completion: @escaping (ResponeStatus<MusicVideoList>) -> Void) {
        
        let url = "https://itunes.apple.com/search?term=onedirection&entity=musicVideo"
        APIManager.getData(urlPath: url) { (result: ResponeStatus<MusicVideoList>) in
            completion(result)
        }
    }
}

class DataBaseRepository: BaseService {
    
    func getMusicVideoList(completion: @escaping (ResponeStatus<MusicVideoList>) -> Void) {
        //If you want to get music video list from DB
    }
}
