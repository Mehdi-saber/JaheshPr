//
//  GalleryCollectionCellCollectionViewCell.swift
//  ARToolKit5iOS
//
//  Created by mehdi sabermahani on 4/23/17.
//
//

import AlamofireImage

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var title: UILabel!
    public func configure(movie:Movie) {
        let placeholderImage = UIImage(named: "PlaceHolderImage")!
        imageView.af_setImage(withURL: movie.poster!, placeholderImage: placeholderImage)
        title.text=movie.title!
    }
}
