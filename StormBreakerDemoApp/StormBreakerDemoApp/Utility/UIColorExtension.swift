//
//  UIColorExtension.swift
//  StormBreakerDemoApp
//
//  Created by Shival Pandya on 2020-01-19.
//  Copyright © 2020 Shival Pandya. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars = ["F","F"] + chars
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }

    
    class func customBlack() -> UIColor? {
        let black = UIColor(hexString: "#000")
        return black
    }
    
    class func customWhite() -> UIColor? {
           let white = UIColor(hexString: "#FFF")
           return white
       }
    
    class func customPurple() -> UIColor? {
        let purple = UIColor(hexString: "#605B70")
        return purple
    }
    
    class func customGreen() -> UIColor? {
        let green = UIColor(hexString: "#76999D")
        return green
    }
    
    class func customLightGray() -> UIColor? {
        let lightGray = UIColor(hexString: "#BABABA")
        return lightGray
    }
}
