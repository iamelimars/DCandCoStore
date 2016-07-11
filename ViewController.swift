//
//  ViewController.swift
//  DCandCo
//
//  Created by iMac on 7/5/16.
//  Copyright © 2016 Marshall. All rights reserved.
//

import UIKit
import Moltin
import SDWebImage

class CategorieShopViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var Array = [String]()
    var objects = [AnyObject]()
    private let PRODUCTS_LIST_SEGUE_IDENTIFIER = "productsListSegue"
    private var selectedCollectionDict:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 1, green: 152/255, blue: 1, alpha: 1), NSFontAttributeName: UIFont(name: "Anders", size: 25)!]

        //self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Anders", size: 20)!]

        
        
        Moltin.sharedInstance().setPublicId("vjA7hGXCc7GAgvIpaYUdAzv7VYMp5HZiJkCOwwlX6K")
        
        //Make  a call to retrieve the store products
        Moltin.sharedInstance().category.listingWithParameters(nil, success: { (responseDictionary) in
            
            //Assign  products array to our objects property
            self.objects = responseDictionary["result"] as! [AnyObject]
            
            //Tell th tableView to looad its data
            self.collectionView!.reloadData()
            
            
        }) { (responseDictionary, error) in
            print("Something went wrong")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CategoriesCell
        
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.layer.borderWidth = 0.5
        
        let Button = cell.viewWithTag(1) as! UILabel
        let object = objects[indexPath.row] as! [String:AnyObject]
        Button.text = object["title"] as? String
        
        var imageUrl = ""

        if let images = object["images"] as? NSArray {
            if (images.firstObject != nil) {
                imageUrl = images.firstObject?.valueForKeyPath("url.https") as! String
            }
        }
        
        cell.imageView?.sd_setImageWithURL(NSURL(string: imageUrl))
        
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        
        return CGSizeMake(screenWidth - 20, screenWidth)
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedCollectionDict = objects[indexPath.row] as? NSDictionary
        
        let itemselected = selectedCollectionDict!.valueForKey("id") as? String
        
        print("%@", itemselected)
        
        performSegueWithIdentifier(PRODUCTS_LIST_SEGUE_IDENTIFIER, sender: self)

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == PRODUCTS_LIST_SEGUE_IDENTIFIER {
            // Set up products list view!
            let newViewController = segue.destinationViewController as! ProductsCollectionViewController
            
            newViewController.title = selectedCollectionDict!.valueForKey("title") as? String
            newViewController.collectionId = selectedCollectionDict!.valueForKeyPath("id") as? String
            
        }
        
    }

    

}

