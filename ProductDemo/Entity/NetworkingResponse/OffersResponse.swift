//
//  OffersResponse.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import Foundation

struct OffersResponse: Codable {
    
    enum OfferType: String, Codable {
        
        case product
        case item
    }
    
    let id: String
    let name: String
    let desc: String?
    let groupName: String
    let type: OfferType
    let image: String?
    let price: Double?
    let discount: Double?
}
