//
//  MeteorNetworking.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation

class MeteorNetworking {

    
    /*
     * Makes a GET request to NASA API and
     * completion returns an array of Meteors
     */
    func retrieveMeteorsFromAPI(completion: @escaping ([Meteor]) -> ()) {
        var meteors = [Meteor]()
        let url = URL(string: "https://data.nasa.gov/resource/y77d-th95.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let json = data {
                let decoder = JSONDecoder()
                do {
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    meteors = try decoder.decode(Array<Meteor>.self, from: json)
                    meteors.sort { ($0.massValue ?? 0) > ($1.massValue ?? 0) }
                    
                    completion(meteors)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}
