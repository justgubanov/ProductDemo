//
//  StrikethroughLabel.swift
//  ProductDemo
//
//  Created by Александр Губанов on 15.12.2020.
//

import UIKit

@IBDesignable class StrikethroughLabel: UILabel {

    override var text: String? {
        didSet {
            attributedText = applyModifiers(to: text)
        }
    }

    private func applyModifiers(to text: String?) -> NSAttributedString? {
        guard let text = text else {
            return nil
        }
        let strikethroughAttributes = [
            NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: text, attributes: strikethroughAttributes)
        return attributedString
    }
}
