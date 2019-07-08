//
//  AssetManager.swift
//  Carfax Vehicles
//
//  Created by Edgar Delgado on 7/4/19.
//  Copyright © 2019 Edgar Delgado. All rights reserved.
//

import UIKit

class AssetManager {
    static var shared = AssetManager()
    private let cache = NSCache<NSURL, UIImage>()
    private init() { }
    
    enum AssetManagerError: Error {
        case invalidURL
        case dataConversionFailed
    }
    
    func image(for url: URL?, completion: @escaping (Result<(UIImage, URL), Error>) -> Void) {
        guard let url = url else {
            return completion(.failure(AssetManagerError.invalidURL))
        }
        guard let image = cache.object(forKey: url as NSURL) else {
            URLSession.shared.dataTask(with: url) { [cache] (data, _, error) in
                guard let image = data.flatMap(UIImage.init(data:)) else {
                    return completion(.failure(error ?? AssetManagerError.dataConversionFailed))
                }
                completion(.success((image, url)))
                cache.setObject(image, forKey: url as NSURL)
            }.resume()
            return
        }
        completion(.success((image, url)))
    }
    
}
