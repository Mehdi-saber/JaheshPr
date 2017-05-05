//
//  DetailCollectionViewCell.swift
//  JaheshPr
//
//  Created by mehdi sabermahani on 5/5/17.
//  Copyright © 2017 test1000. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    public func configure(imageURL:URL) {
        let placeholderImage = UIImage(named: "PlaceHolderImage")!
        imageView.af_setImage(withURL: imageURL, placeholderImage: placeholderImage)
    }
}
