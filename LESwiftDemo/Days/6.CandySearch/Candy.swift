//
//  Candy.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/21.
//  Copyright © 2019 LQQ. All rights reserved.
//

import UIKit

class Candy: NSObject {
    var category: String
    var name : String
    init(category: String, name: String) {
        self.category = category
        self.name = name
    }
}
