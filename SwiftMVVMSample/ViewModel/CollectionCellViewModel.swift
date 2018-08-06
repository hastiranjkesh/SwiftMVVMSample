//
//  CollectionCellViewModel.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation

class CollectionCellViewModel {
    var imagePath: String
    var trackName: String
    var dataTask: URLSessionDataTask?
    var defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var imageData: Dynamic<Data> = Dynamic(Data())
    var service: NetworkRepository
    
    init(imagePath: String, trackName: String, service: NetworkRepository) {
        self.imagePath = imagePath
        self.trackName = trackName
        self.service = service
    }
    
    func downloadImage(path: String) {
        service.downloadImage(path: path) { (data) in
            self.imageData.value = data
        }
    }
}
