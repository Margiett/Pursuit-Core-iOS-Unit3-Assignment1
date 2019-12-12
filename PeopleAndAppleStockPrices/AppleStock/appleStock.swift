//
//  appleStock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Margiett Gil on 12/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppleStock: Codable {
    let date: String
    let close: String
    let open: Double
    let label: String
}
//var appleStock = [AppleStock]()

extension AppleStock {
    static func getStocks() -> [AppleStock] {
        
        var appleStockInfo = [AppleStock]()
        
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else{
            fatalError("unable to get the apple stock data ")
        }
        
        do{
            let data = try Data(contentsOf: fileURL)
            let appleStockData = try JSONDecoder().decode(AppleStock.self, from: data)
           
            // why is not leting me sort appleStockData ???????????????????????
            appleStockInfo = appleStockData.sorted {$0.date < $1.date}
            
        } catch {
            fatalError("\(error)")
        }
        return appleStockInfo
    }
}

