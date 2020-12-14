//
//  OfferTableViewController.swift
//  ProductDemo
//
//  Created by Александр Губанов on 14.12.2020.
//

import UIKit

class OfferTableViewController: UITableViewController {
    
    private let cellReuseIdentifier = "reuseIdentifier"
    
    private lazy var offerProvider: OfferProvider = {
        let provider = OfferProvider()
        provider.delegate = self
        return provider
    }()
    
    private var offerGroups = [OfferGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offerProvider.getGroupedOffers()
        navigationItem.titleView = UISearchBar()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return offerGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerGroups[section].offers.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return offerGroups[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        guard let offerCell = cell as? OfferTableViewCell else {
            return cell
        }
        let section = offerGroups[indexPath.section]
        let offer = section.offers[indexPath.row]
        
        offerCell.offer = offer
        return offerCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {}
}

extension OfferTableViewController: OfferProviderDelegate {
    
    func offerProviderDidReceiveOffers(_ offers: [Offer]) {
        DispatchQueue.main.async { [weak self] in
            self?.offerGroups = [OfferGroup(name: "Response", offers: offers)]
            self?.tableView.reloadData()
        }
    }
    
    func offerProviderDidFailed() {
        
    }
}
