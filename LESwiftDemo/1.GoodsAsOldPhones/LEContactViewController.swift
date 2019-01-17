//
//  LEContactViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/16.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class LEContactViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            scrollView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
        } else {
            scrollView.frame = CGRect(x: 0, y: topLayoutGuide.length, width: view.frame.width, height: view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length)
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
    }
}


