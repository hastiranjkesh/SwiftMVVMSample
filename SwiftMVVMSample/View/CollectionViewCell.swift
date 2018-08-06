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
    
    var viewModel: CollectionCellViewModel! {
        didSet {
            bindUI()
            setContent()
        }
    }
    
    func bindUI() {
        viewModel.imageData.bind = { [unowned self] data in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func setContent() {
        imageView.image = #imageLiteral(resourceName: "placeholder")
        trackNameLabel.text = viewModel.trackName
        viewModel.downloadImage(path: viewModel.imagePath)
    }
}
