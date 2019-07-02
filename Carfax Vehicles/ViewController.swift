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
    
    var cars = [UIImage(named: "camaro"), UIImage(named: "wrx"), UIImage(named: "silverado")]
    var carNames = ["2014 Chevrolet Camaro SS", "2015 Subaru WRX STI", "2016 Chevrolet Silverado Z71"]
    var carPrice = ["15,283", "23,234", "29,321"]
    var carMileage = ["100k", "123k", "23k"]
    var carLocation = ["Fredricksburg, VA", "Santa Ana, CA", "St Louis, MO"]
    var carDealerPhoneNumber = ["(714)243-3423", "(434)424-2342", "(243)423-2432"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
        cell.carImageView.image = cars[indexPath.row]
        cell.carName.text = carNames[indexPath.row]
        cell.carPrice.text = carPrice[indexPath.row]
        cell.carMileage.text = carMileage[indexPath.row]
        cell.carLocation.text = carLocation[indexPath.row]
        
        return cell
    }
}
