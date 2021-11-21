//
//  PhotoCollectionViewCell.swift
//  Photorama
//
//  Created by Magic Keegan on 11/21/21.
//

import UIKit

class PhotoCollectionViewCell:UICollectionViewCell{
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func update(displaying image: UIImage?){
        if let imageToDisplay = image{
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        }
        else{
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
