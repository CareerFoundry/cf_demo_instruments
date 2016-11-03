//
//  PhotoCollectionViewCell.swift
//  InstrumentsDemo
//
//  Created by Hesham Abd-Elmegid on 8/2/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
