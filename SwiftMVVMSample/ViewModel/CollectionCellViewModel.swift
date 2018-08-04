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
    
    init(imagePath: String, trackName: String) {
        self.imagePath = imagePath
        self.trackName = trackName
    }
}
