//
//  CategoriesCell.swift
//  DCandCo
//
//  Created by iMac on 7/5/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit
import SDWebImage

class CategoriesCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func setCollectionDictionary(dict: NSDictionary) {
        // Set up the cell based on the values of the dictionary that we've been passed
        
        
        // Extract image URL and set that too...
        var imageUrl = ""
        
        if let images = dict.valueForKey("images") as? NSArray {
            if (images.firstObject != nil) {
                imageUrl = images.firstObject?.valueForKeyPath("url.https") as! String
            }
        }
        
        //collectionImage?.sd_setImageWithURL(NSURL(string: imageUrl))
        
        
    }
    

}
