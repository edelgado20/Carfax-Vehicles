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
    
    let client = Client()
    let url = URL(string: "https://carfax-for-consumers.firebaseio.com/assignment.json")!
    var carListings = [Listing]()
    
//    var cars = [UIImage(named: "camaro"), UIImage(named: "wrx"), UIImage(named: "silverado")]
//    var carNames = ["2014 Chevrolet Camaro SS", "2015 Subaru WRX STI", "2016 Chevrolet Silverado Z71"]
//    var carPrice = ["15,283", "23,234", "29,321"]
//    var carMileage = ["100k", "123k", "23k"]
//    var carLocation = ["Fredricksburg, VA", "Santa Ana, CA", "St Louis, MO"]
//    var carDealerPhoneNumber = ["(714)243-3423", "(434)424-2342", "(243)423-2432"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.fetchCarListings(from: url) { (data, error) in
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
                print(results)
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
        //cell.carImageView.image =
        cell.carName.text = "\(listing.year) \(listing.make) \(listing.model) \(listing.trim)"
        cell.carPrice.text = "\(listing.listPrice)"
        cell.carMileage.text = "\(listing.mileage)"
        cell.carLocation.text = "\(listing.dealer.city), \(listing.dealer.state)"
        
        return cell
    }
}
