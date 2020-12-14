//
//  OfferProvider.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import Foundation

protocol OfferProviderDelegate: class {
    
    func offerProviderDidFailed()
    func offerProviderDidReceiveOffers(_ offers: [Offer])
}

final class OfferProvider {
    
    private lazy var requester: DataRequester = {
        let requester = DataRequester()
        requester.delegate = self
        return requester
    }()
    
    weak var delegate: OfferProviderDelegate?
    
    func getGroupedOffers() {
        requester.requestData(type: .offers)
    }
    
    private func makeOffers(from data: Data?) -> [Offer] {
        let offers = [Offer]()
        
        guard let data = data,
              let response = try? JSONDecoder().decode(Array<OffersResponse>.self, from: data) else {
            return offers
        }
        
        return response.map { offerResponse in
            if let discount = offerResponse.discount, let price = offerResponse.price {
                let currentPrice = price * discount
                
                return Offer(image: nil,
                             title: offerResponse.name,
                             slogan: offerResponse.desc,
                             price: currentPrice,
                             oldPrice: offerResponse.price)
            } else {
                return Offer(image: nil,
                             title: offerResponse.name,
                             slogan: offerResponse.desc,
                             price: offerResponse.price,
                             oldPrice: nil)
            }
        }
    }
}

extension OfferProvider: DataRequesterDelegate {
    
    func dataRequesterDidFail() {
        delegate?.offerProviderDidFailed()
    }
    
    func dataRequesterDidReceiveData(_ data: Data) {
        let offers = makeOffers(from: data)
        delegate?.offerProviderDidReceiveOffers(offers)
    }
}
