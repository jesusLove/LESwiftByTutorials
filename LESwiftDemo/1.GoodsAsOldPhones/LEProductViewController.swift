//
//  LEProductViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/16.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEProductViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLB: UILabel!
    
    var product: LEProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productNameLB.text = product?.name
        if let imageName = product?.fullscreenImageName {
            productImageView.image = UIImage(named: imageName)
        }
    }
    
    @IBAction func addToCartButtonDidTap(_ sender: UIButton) {
        print("Add to cart successfully")
    }
}
