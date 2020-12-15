//
//  DiscountLabel.swift
//  ProductDemo
//
//  Created by Александр Губанов on 15.12.2020.
//

import UIKit

@IBDesignable class DiscountLabel: UILabel {
    
    private var insets: UIEdgeInsets {
        let thirdHeight = 0.33 * frame.height
        return UIEdgeInsets(top: 0, left: thirdHeight, bottom: 0, right: thirdHeight)
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let newWidth = originalSize.width + insets.left + insets.right
        let newSize = CGSize(width: newWidth, height: originalSize.height)
        return newSize
    }
    
    override var frame: CGRect {
        didSet {
            layer.cornerRadius = 0.5 * frame.height
        }
    }
    
    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: insets)
        
        clipsToBounds = true
        super.drawText(in: newRect)
    }
}
