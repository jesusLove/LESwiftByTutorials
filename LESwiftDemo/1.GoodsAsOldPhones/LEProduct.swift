//
//  LEProduct.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/16.
//  Copyright © 2019 LQQ. All rights reserved.
//

import Foundation

class LEProduct {
    var name: String?
    var cellImageName: String?
    var fullscreenImageName: String?
    init(name: String, cellImageName: String, fullscreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullscreenImageName = fullscreenImageName
    }
}
