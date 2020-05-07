//
//  UIColor+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit

extension UIColor {
    static var primary: UIColor { return UIColor(hex: 0x6AFDF0) }
    static var siGray: UIColor { return UIColor(hex: 0xF5F0ED) }

}

extension UIColor {
    convenience init(hex: UInt32) {
        var (a, r, g, b) = (hex >> 24 & 0xFF, hex >> 16 & 0xFF, hex >> 8 & 0xFF, hex & 0xFF)
        if a == 0 {
            a = 0xFF
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
