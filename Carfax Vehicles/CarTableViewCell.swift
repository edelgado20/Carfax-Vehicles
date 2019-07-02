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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
