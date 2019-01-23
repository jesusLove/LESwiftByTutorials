//
//  CustomViewController.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/23.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        print("================进入\(self)====================")
    }
    deinit {
        print("========== 销毁 ==========")
    }
}
