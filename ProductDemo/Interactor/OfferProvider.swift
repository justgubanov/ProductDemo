//
//  OfferProvider.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import Foundation

final class OfferProvider {
    
    func getGroupedOffers() -> [OfferGroup] {
        var groups = [OfferGroup]()
        
        let offers = OfferGroup(name: "Offers",
                                offers: [Offer(title: "Offer 1", slogan: "Lores", price: 50, oldPrice: 100),
                                         Offer(title: "Offer 2", slogan: "Impsum", price: 20)])
        
        let sales = OfferGroup(name: "Sales",
                               offers: [Offer(title: "Sale 1", slogan: "Lores", price: 15, oldPrice: 30),
                                        Offer(title: "Sale 2", slogan: "Impsum", price: 11),
                                        Offer(title: "Sale 3", slogan: "Lores", price: 50)])
        
        groups.append(offers)
        groups.append(sales)
        return groups
    }
}
