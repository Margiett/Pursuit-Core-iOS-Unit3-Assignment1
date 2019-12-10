//
//  NetworkErrorAPI.swift
//  PeopleAndAppleStockPrices
//
//  Created by Margiett Gil on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum NetWorkError: Error {
    case badURL(String)
    case networkClient(Error)
    case noResponse
    case noData
    case badStatusCode(Int)
    case decodingError(Error)
    
}
struct RandomUrlAPI {
    
    static func fetchRandomUser(endpointURLString:String, completion: @escaping (Result<Data, NetWorkError>) -> ()) {
       
    // this is the URL calling the URL from the internet
        guard let url = URL(string: endpointURLString) else {
        completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        // The URLSession class and related classes provide an API for downloading data from and uploading data to endpoints indicated by URLs.
        let dataTask = URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if let error = error {
                completion(.failure(.networkClient(error)))
        }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            guard let data = data else {
                           completion(.failure(.noData))
                           return
                       }
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
                }
            do {
//                let user = try JSONDecoder().decode([RandomUserData].self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(.decodingError(error)))
            }
    }
        dataTask.resume()
        
}

}
