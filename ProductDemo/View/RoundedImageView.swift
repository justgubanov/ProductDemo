//
//  RoundedImageView.swift
//  ProductDemo
//
//  Created by Александр Губанов on 15.12.2020.
//

import UIKit

@IBDesignable class RoundedImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
}
