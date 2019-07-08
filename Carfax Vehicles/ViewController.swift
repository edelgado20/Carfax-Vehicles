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
  
    var carListings = [Listing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        Client.getListings { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let listings):
                self?.carListings = listings
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath)
        let listing = carListings[indexPath.row]
        (cell as? CarTableViewCell)?.configure(with: listing)
    
        return cell
    }
}
