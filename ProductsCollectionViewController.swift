//
//  ProductsCollectionViewController.swift
//  DCandCo
//
//  Created by iMac on 7/5/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit
import Moltin
import SDWebImage

class ProductsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let CELL_REUSE_IDENTIFIER = "ProductCell"
    
    private let LOAD_MORE_CELL_IDENTIFIER = "ProductsLoadMoreCell"
    
    private let PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER = "productDetailSegue"
    
    private var products:NSMutableArray = NSMutableArray()
    
    private var paginationOffset:Int = 0
    
    private var showLoadMore:Bool = true
    
    private let PAGINATION_LIMIT:Int = 3
    
    private var selectedProductDict:NSDictionary?
    
    var collectionId:String?
    var objects = [AnyObject]()

    override func viewDidLoad() {
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 1, green: 152/255, blue: 1, alpha: 1)
        loadProducts(true)
    }
    private func loadProducts(showLoadingAnimation: Bool){
        assert(collectionId != nil, "Collection ID is required!")
        print("%@", collectionId)
        // Load in the next set of products...
        
        // Show loading if neccesary?
        
        
        Moltin.sharedInstance().product.listingWithParameters(["category": collectionId!], success: { (response) in
            // Let's use this response!
            
            self.objects = response ["result"] as! [AnyObject]
             /*
            if let newProducts:NSArray = response["result"] as? NSArray {
                self.products.addObjectsFromArray(newProducts as [AnyObject])
                print("success")
                
            }
            
            
            let responseDictionary = response as NSDictionary
           
            if let newOffset:NSNumber = responseDictionary.valueForKeyPath("pagination.offsets.next") as? NSNumber {
                self.paginationOffset = newOffset.integerValue
                
            }
            
            if let totalProducts:NSNumber = responseDictionary.valueForKeyPath("pagination.total") as? NSNumber {
                // If we have all the products already, don't show the 'load more' button!
                if totalProducts.integerValue >= self.products.count {
                    self.showLoadMore = false
                }
                
            }
            */
            self.collectionView!.reloadData()
            
        }) { (response, error) -> Void in
            // Something went wrong!
                        
            print("Something went wrong...")
            print(error)
        }
        
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return objects.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CELL_REUSE_IDENTIFIER, forIndexPath: indexPath) as! ProductsCollectionCell
        /*
        if (showLoadMore && indexPath.row > (products.count - 1)) {
            // it's the last item - show a 'Load more' cell for pagination instead.
            let cell = tableView.dequeueReusableCellWithIdentifier(LOAD_MORE_CELL_IDENTIFIER, forIndexPath: indexPath) as! ProductsLoadMoreTableViewCell
            
            return cell
        }
        */
        
        
        
        
        //let product:NSDictionary = products.objectAtIndex(row) as! NSDictionary
        
        let object = objects[indexPath.row] as! NSDictionary

        cell.productNameLabel.text = object["title"] as? String
        
        cell.productPriceLabel.text = object.valueForKeyPath("price.value") as? String
        
        var imageUrl = ""

        if let images = object["images"] as? NSArray {
            if (images.firstObject != nil) {
                imageUrl = images.firstObject?.valueForKeyPath("url.https") as! String
            }
        }
        
        cell.imageView?.sd_setImageWithURL(NSURL(string: imageUrl))
        
        
        return cell

    }
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            
        }
    }
    
    
}
