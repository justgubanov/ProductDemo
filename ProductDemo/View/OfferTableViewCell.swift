//
//  OfferTableViewCell.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    @IBOutlet private weak var offerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var sloganLabel: UILabel!
    
    @IBOutlet private weak var oldPriceLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    
    @IBOutlet private weak var addToCartButton: UIButton!
    
    private var discountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    private var priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    var offer: Offer? {
        didSet {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        let isDiscounted = offer?.oldPrice != nil
        
        offerImageView.image = offer?.image
        nameLabel.text = offer?.title
        sloganLabel.text = offer?.slogan
        
        priceLabel.text = priceFormatter.string(for: offer?.price)
        oldPriceLabel.text = priceFormatter.string(for: offer?.oldPrice)
        discountLabel.text = discountFormatter.string(for: offer?.discount)
        
        oldPriceLabel.isHidden = !isDiscounted
        discountLabel.isHidden = !isDiscounted
    }
}
