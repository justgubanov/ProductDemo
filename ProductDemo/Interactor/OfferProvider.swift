//
//  OfferProvider.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import UIKit

protocol OfferProviderDelegate: class {
    
    func offerProviderDidFailed()
    func offerProviderDidReceiveOfferGroups(_ offerGroups: [OfferGroup])
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
    
    private func makeOfferGroups(from data: Data?) -> [OfferGroup] {
        guard let data = data,
              let response = try? JSONDecoder().decode(Array<OfferResponse>.self, from: data) else {
            return []
        }
        var groups = [String : [Offer]]()
        
        for offerResponse in response {
            let image = loadImage(for: offerResponse)
            let (price, oldPrice) = getPrices(from: offerResponse)
            let offer = Offer(image: image,
                              title: offerResponse.name,
                              slogan: offerResponse.desc,
                              price: price,
                              oldPrice: oldPrice)

            let groupName = offerResponse.groupName
            
            if var group = groups[groupName] {
                group.append(offer)
                groups[groupName] = group
            } else {
                groups[groupName] = [offer]
            }
        }
        return groups.map {
            OfferGroup(name: $0.key, offers: $0.value)
        }
    }
    
    private func getPrices(from response: OfferResponse) -> (price: Double?, oldPrice: Double?) {
        guard let price = response.price else {
            return (nil, nil)
        }
        
        if let discount = response.discount {
            return (price * discount, price)
        } else {
            return (price, nil)
        }
    }
    
    private func loadImage(for response: OfferResponse) -> UIImage? {
        guard let urlString = response.image,
              let imageURL = URL(string: urlString),
              let data = try? Data(contentsOf: imageURL),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}

extension OfferProvider: DataRequesterDelegate {
    
    func dataRequesterDidFail() {
        delegate?.offerProviderDidFailed()
    }
    
    func dataRequesterDidReceiveData(_ data: Data) {
        let offerGroups = makeOfferGroups(from: data)
        delegate?.offerProviderDidReceiveOfferGroups(offerGroups)
    }
}
