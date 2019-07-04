//
//  Client.swift
//  Carfax Vehicles
//
//  Created by Edgar Delgado on 7/2/19.
//  Copyright © 2019 Edgar Delgado. All rights reserved.
//

import UIKit

class Client {
    
    static var shared = Client()
    
    enum FetchError: Error {
        case noData
        case unknown
    }
    
    func fetch(from url: URL, completion: @escaping (Data?, FetchError?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            //DispatchQueue.main.async {
                if error != nil {
                    print(error!)
                    completion(nil, .unknown)
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                completion(data, nil)
            //}
        }.resume()
    }
    
}
