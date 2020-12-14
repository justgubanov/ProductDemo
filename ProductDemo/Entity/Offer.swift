//
//  Offer.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import UIKit

struct Offer {
    
    var image: UIImage?
    var title: String
    var slogan: String?
    var price: Double?
    var oldPrice: Double?
    
    var discount: Double? {
        guard let oldPrice = oldPrice,
              let price = price else {
            return nil
        }
        return (price / oldPrice) - 1
    }
}
