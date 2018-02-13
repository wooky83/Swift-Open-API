//
//  Utility.swift
//  SwiftReference
//
//  Created by 1002659 on 2018. 2. 8..
//  Copyright © 2018년 wooky83. All rights reserved.
//

import UIKit

class Utility: NSObject {

    static func stringDigitsFromString(_ str: String) -> String {
        return str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
