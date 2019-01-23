//
//  Date+Extension.swift
//  LESwiftDemo
//
//  Created by LQQ on 2019/1/18.
//  Copyright © 2019 LQQ. All rights reserved.
//

import Foundation

public extension Date {
    static func dateFormString(_ str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: str) ?? Date()
    }
    func dateToString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
