//
//  Extensions.swift
//  Concentration
//
//  Created by 高浩铭 on 6/11/20.
//  Copyright © 2020 Haoming Gao. All rights reserved.
//

import Foundation

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
