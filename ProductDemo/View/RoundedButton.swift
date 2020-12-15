//
//  RoundedButton.swift
//  ProductDemo
//
//  Created by Александр Губанов on 16.12.2020.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let maxDimension = max(originalSize.width, originalSize.height)
        let newSize = CGSize(width: maxDimension, height: maxDimension)
        return newSize
    }
    
    override var frame: CGRect {
        didSet {
            layer.cornerRadius = 0.5 * frame.height
        }
    }
    
    override func draw(_ draw: CGRect) {
        clipsToBounds = true
        super.draw(draw)
    }
}
