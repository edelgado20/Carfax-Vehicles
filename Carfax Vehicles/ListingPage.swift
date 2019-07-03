//
//  ListingPage.swift
//  Carfax Vehicles
//
//  Created by Edgar Delgado on 7/2/19.
//  Copyright © 2019 Edgar Delgado. All rights reserved.
//

import Foundation

// MARK: - ListingPage
struct ListingPage: Codable {
    let listings: [Listing]
}

// MARK: - Listing
struct Listing: Codable {
    let dealer: Dealer
    let images: Images?
    let listPrice: Int
    let make: String
    let mileage: Int
    let model: String
    let trim: String
    let year: Int
}

// MARK: - Dealer
struct Dealer: Codable {
    let city: String
    let phone: String
    let state: State
}

enum State: String, Codable {
    case az = "AZ"
    case ca = "CA"
    case nj = "NJ"
}

// MARK: - Images
struct Images: Codable {
    let baseURL: String
    let firstPhoto: FirstPhoto
    let large, medium, small: [String]
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "baseUrl"
        case firstPhoto, large, medium, small
    }
}

// MARK: - FirstPhoto
struct FirstPhoto: Codable {
    let large, medium, small: String
}
