//
//  LEMeUser.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/17.
//  Copyright © 2019 LQQ. All rights reserved.
//

import Foundation

class LEMeUser {
    var name: String
    var avatarName: String
    var education: String
    init(name: String, avatarName: String = "bayMax", education: String) {
        self.name = name
        self.avatarName = avatarName
        self.education = education
    }
}
