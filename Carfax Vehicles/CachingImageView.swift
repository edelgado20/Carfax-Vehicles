//
//  CachingImageView.swift
//  Carfax Vehicles
//
//  Created by Edgar Delgado on 7/3/19.
//  Copyright © 2019 Edgar Delgado. All rights reserved.
//

import UIKit

class CachingImageView: UIImageView {
    var imageByURL = [URL: UIImage]()
    
    func setImage(with url: URL?) {
        guard let url = url else {
            image = nil
            return
        }
        
        if let image = imageByURL[url] {
            self.image = image
        }
        
        Client.shared.fetch(from: url) { (data, _) in
            defer {
                self.imageByURL[url] = self.image
            }
            guard let data = data else {
                self.image = nil
                return
            }
            
            let image = UIImage(data: data)
            self.image = image
        }
        
    }
    
}
