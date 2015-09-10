//
//  WishDetailViewController.swift
//  Wishful
//
//  Created by Scott Barlow on 8/24/15.
//  Copyright © 2015 Scott Barlow. All rights reserved.
//

import UIKit

class WishDetailViewController: UIViewController {
    
    @IBOutlet weak var wishDescription: UILabel!
    @IBOutlet weak var wishInfo: UILabel!
    @IBOutlet weak var wishImage: UIImageView!
    
    var wish: Wish? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.wishDescription.text = self.wish!.desc
        self.wishInfo.text = self.wish!.info
        self.wishImage.image = UIImage(data: self.wish!.image!)
        
    }


}
