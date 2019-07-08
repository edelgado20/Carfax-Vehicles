//
//  Client.swift
//  Carfax Vehicles
//
//  Created by Edgar Delgado on 7/2/19.
//  Copyright © 2019 Edgar Delgado. All rights reserved.
//

import UIKit

class Client {
    
    static let carListingURL = URL(string: "https://carfax-for-consumers.firebaseio.com/assignment.json")!
    
    enum FetchError: Error {
        case noData
        case unknown
    }
    
    private static func fetch(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                return completion(.failure(error ?? FetchError.unknown))
            }
            guard let data = data else {
                return completion(.failure(FetchError.noData))
            }
            
            completion(.success(data))
        }.resume()
    }
    
    static func getListings(completion: @escaping (Result<[Listing], Error>) -> Void) {
        fetch(from: Client.carListingURL) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(ListingPage.self, from: data)
                    completion(.success(results.listings))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
