//
//  UIScrollView+Utils.swift
//  SendInvites
//
//  Created by Oluwadamisi Pikuda on 07/05/2020.
//  Copyright © 2020 Damisi Pikuda. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        let offset = CGPoint(x: -adjustedContentInset.left, y: -adjustedContentInset.top)
        self.setContentOffset(offset, animated: animated)
    }
}
