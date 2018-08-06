//
//  CollectionViewCell.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    var dataTask: URLSessionDataTask?
    var defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var viewModel: CollectionCellViewModel! {
        didSet {
            setContent()
        }
    }
    
    func setContent() {
        imageView.image = #imageLiteral(resourceName: "placeholder")
        trackNameLabel.text = viewModel.trackName
        
        if let imageUrl = URL(string: viewModel.imagePath) {
            dataTask = defaultSession.dataTask(with: imageUrl, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            })
            dataTask?.resume()
        }
    }
}
