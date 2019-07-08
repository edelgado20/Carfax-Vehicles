//
//  CarTableViewCell.swift
//  Carfax Vehicles
//
//  Created by Edgar Delgado on 7/1/19.
//  Copyright © 2019 Edgar Delgado. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carMileage: UILabel!
    @IBOutlet weak var carLocation: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    static let reuseIdentifier: String = "cell"
    
    func configure(with listing: Listing) {
        AssetManager.shared.image(for: listing.images?.firstPhoto.large) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let image, let url):
                guard url == listing.images?.firstPhoto.large else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.carImageView.image = image
                }
                
            }
        }
        
        carName.text = "\(listing.year) \(listing.make) \(listing.model) \(listing.trim)"
        carPrice.text = "$\(listing.listPrice)"
        carMileage.text = "\(listing.mileage) Mi"
        carLocation.text = "\(listing.dealer.city), \(listing.dealer.state)"
    }
    
}
