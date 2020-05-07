//
//  UIFont+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 06/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit

extension UIFont {
    private enum FontName: String {
        case graphikRegular = "Graphik-Regular"
        case graphikBold = "Graphik-Bold"
    }

    private static func getFontWith(fontName: FontName, andSize size: CGFloat) -> UIFont {
        if let requestedFont = UIFont(name: fontName.rawValue, size: size) {
            return requestedFont
        }

        assertionFailure("Missing font: \(fontName.rawValue)")
        return UIFont.systemFont(ofSize: size)
    }

    static func graphikRegular(ofSize fontSize: CGFloat) -> UIFont {
        return getFontWith(fontName: .graphikRegular, andSize: fontSize)
    }

    static func graphikBold(ofSize fontSize: CGFloat) -> UIFont {
        return getFontWith(fontName: .graphikBold, andSize: fontSize)
    }
}
