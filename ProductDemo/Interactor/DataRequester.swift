//
//  Network.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import Foundation

protocol DataRequesterDelegate: class {
    
    func dataRequesterDidFail()
    func dataRequesterDidReceiveData(_ data: Data)
}

final class DataRequester {
    
    enum DataType {
        
        case offers
        case banners
    }
    
    weak var delegate: DataRequesterDelegate?
    
    func requestData(type dataType: DataType) {
        guard let url = makeUrl(for: dataType) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard error == nil,
                  let data = data else {
                self?.delegate?.dataRequesterDidFail()
                return
            }
            self?.delegate?.dataRequesterDidReceiveData(data)
        }
        task.resume()
    }
    
    private func makeUrl(for dataType: DataType) -> URL? {
        let path = getRequestPath(dataType: dataType)
        let urlString = "https://s3.eu-central-1.amazonaws.com/sl.files/\(path)"
        return URL(string: urlString)
    }
    
    private func getRequestPath(dataType: DataType) -> String {
        switch dataType {
        case .offers:
            return "offers.json"
        case .banners:
            return "banners.json"
        }
    }
}
