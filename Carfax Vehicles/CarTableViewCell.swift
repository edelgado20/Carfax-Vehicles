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
    var phoneNumber: String?
    
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
        
        let trim = listing.trim == "Unspecified" ? "" : listing.trim
        carName.text = "\(listing.year) \(listing.make) \(listing.model) \(trim)"
        carPrice.text = "$\(listing.listPrice)"
        carMileage.text = "\(listing.mileage/1000)K Mi"
        carLocation.text = "\(listing.dealer.city), \(listing.dealer.state)"
        phoneNumber = listing.dealer.phone
        phoneNumberButton.setTitle(format(phoneNumber: listing.dealer.phone), for: .normal)
    }
    
    @IBAction func makePhoneCall(_ sender: Any) {
        guard let number = phoneNumber else { return }
        
        if let phoneCallURL = URL(string: "tel://\(number)") {
            let application: UIApplication = UIApplication.shared
            if application.canOpenURL(phoneCallURL) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    application.openURL(phoneCallURL as URL)
                }
            }
        }
    }
    
    func format(phoneNumber sourcePhoneNumber: String) -> String? {
        var sourceIndex = 0
        
        // Area code
        var areaCode = ""
        let areaCodeLength = 3
        guard let areaCodeSubstring = sourcePhoneNumber.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
            return nil
        }
        areaCode = String(format: "(%@) ", areaCodeSubstring)
        sourceIndex += areaCodeLength
        
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = sourcePhoneNumber.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return nil
        }
        sourceIndex += prefixLength
        
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = sourcePhoneNumber.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return nil
        }
        
        return areaCode + prefix + "-" + suffix
    }
}

extension String {
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
