//
//  MusicVideoList.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation

struct MusicVideoList: Codable {
    public var results: [MusicVideo]?
}


struct MusicVideo: Codable {
    public var collectionName: String?
    public var artworkUrl100: String?
    public var trackName: String?
}
