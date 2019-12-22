//
//  ServerCat.swift
//  Cat Gif ++
//
//  Created by Karim Cordilia on 12/07/2019.
//  Copyright © 2019 Karim Cordilia. All rights reserved.
//

import Foundation

struct CatServerNetworking {
    static func getAPIData(completion: @escaping (Data) -> Void) {
        let endPoint = "https://api.thecatapi.com/v1/images/search?mime_types=image%2Fgif&limit=100"
        let url = URL(string: endPoint)!
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(data!)
        }
        task.resume()
    }
    
    static func loadCatData(completion: @escaping ([ServerCat]) -> Void) {
        getAPIData { resultData in
            do {
                let decoder = JSONDecoder()
                let decodedResult = try decoder.decode([ServerCat].self, from: resultData)
                Cat.saveCats(decodedResult)
                completion(decodedResult)
            } catch let error{
                print(error)
                completion([])
            }
        }
    }
}
