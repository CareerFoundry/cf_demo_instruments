//
//  ViewController.swift
//  InstrumentsDemo
//
//  Created by Hesham Abd-Elmegid on 8/2/16.
//  Copyright © 2016 CareerFoundry. All rights reserved.
//

import UIKit

class PhotosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let itemHeight = 200
    var images = [Int:UIImage]()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PushDetailsViewController" {
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            detailsViewController.image = sender as? UIImage
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCollectionViewCellIdentifier", forIndexPath: indexPath) as! PhotoCollectionViewCell
        let bounds = UIScreen.mainScreen().bounds
        let itemWidth = CGRectGetWidth(bounds)
        let url = NSURL(string: "http://lorempixel.com/\(Int(itemWidth))/\(itemHeight)/")!
        
        if let image = images[indexPath.row] {
            cell.imageView.image = applyFiltersToImage(image)
        } else {
            cell.activityIndicatorView.startAnimating()
            
            fetchImageAtURL(url) { (image) in
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    cell.activityIndicatorView.stopAnimating()
                    cell.imageView.image = self.applyFiltersToImage(image)
                    self.images[indexPath.row] = image
                })
            }
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("PushDetailsViewController", sender: images[indexPath.item])
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let bounds = UIScreen.mainScreen().bounds
        let itemWidth = CGRectGetWidth(bounds)
        return CGSizeMake(itemWidth, CGFloat(itemHeight))
    }
}

extension PhotosViewController {
    func fetchImageAtURL(url: NSURL, success: ((image: UIImage) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            if let data = data, image = UIImage(data: data) {
                success(image: image)
            }
        }.resume()
    }
    
    func applyFiltersToImage(image: UIImage) -> UIImage {
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: "CIPhotoEffectMono") {
            let beginImage = CIImage(image: image)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            if let output = currentFilter.outputImage {
                let cgimg = context.createCGImage(output, fromRect: output.extent)
                let processedImage = UIImage(CGImage: cgimg)
                return processedImage
            }
            
        }
        
        return image
    }
}

