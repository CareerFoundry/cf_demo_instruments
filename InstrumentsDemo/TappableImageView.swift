//
//  TappableImageView.swift
//  InstrumentsDemo
//
//  Created by Hesham Abd-Elmegid on 8/4/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import UIKit

class TappableImageView: UIImageView {
    var tapHandler: ((Void) -> (Void))? {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TappableImageView.tappedImage))
            addGestureRecognizer(tapGestureRecognizer)
            isUserInteractionEnabled = true
        }
    }
    
    func tappedImage() {
        tapHandler?()
    }
}
