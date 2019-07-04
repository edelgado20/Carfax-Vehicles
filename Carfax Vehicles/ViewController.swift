//
//  ViewController.swift
//  Carfax Vehicles
//
//  Created by Edgar Delgado on 7/1/19.
//  Copyright © 2019 Edgar Delgado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
  
    let url = URL(string: "https://carfax-for-consumers.firebaseio.com/assignment.json")!
    var carListings = [Listing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Client.shared.fetch(from: url) { (data, error) in
            defer {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(ListingPage.self, from: data)
                self.carListings = results.listings
            } catch {
                print(error)
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
        let listing = carListings[indexPath.row]
        if let urlString = listing.images?.firstPhoto.large {
            let imageURL = URL(string: urlString)
            cell.carImageView.setImage(with: imageURL)
        }
        
        cell.carName.text = "\(listing.year) \(listing.make) \(listing.model) \(listing.trim)"
        cell.carPrice.text = "$\(listing.listPrice)"
        cell.carMileage.text = "\(listing.mileage) Mi"
        cell.carLocation.text = "\(listing.dealer.city), \(listing.dealer.state)"
        
        return cell
    }
}
