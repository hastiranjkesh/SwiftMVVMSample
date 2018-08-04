//
//  CollectionViewCell.swift
//  SwiftMVVMSample
//
//  Created by hasti ranjkesh on 8/4/18.
//  Copyright © 2018 hasti ranjkesh. All rights reserved.
//

import Foundation
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    var viewModel: CollectionCellViewModel! {
        didSet {
            setContent()
        }
    }
    
    func setContent() {
        
        trackNameLabel.text = viewModel.trackName
        
        if let imageUrl = URL(string: viewModel.imagePath) {
            imageView.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        } else {
            imageView.image = #imageLiteral(resourceName: "placeholder")
        }
    }
}
