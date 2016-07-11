//
//  ProductsCollectionCell.swift
//  DCandCo
//
//  Created by iMac on 7/5/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit

class ProductsCollectionCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    
    func configureProductCell (productDict: NSDictionary) {
        productNameLabel?.text = productDict.valueForKey("title") as? String
        
        productPriceLabel?.text = productDict.valueForKeyPath("price.data.formatted.with_tax") as? String
        
        var imageUrl = ""
        
        if let images = productDict.objectForKey("images") as? NSArray {
            if (images.firstObject != nil) {
                imageUrl = images.firstObject?.valueForKeyPath("url.https") as! String
            }
            
        }
        
        imageView?.sd_setImageWithURL(NSURL(string: imageUrl))
        
        
    }

    
}
