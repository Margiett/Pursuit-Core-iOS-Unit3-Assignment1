//
//  appleStock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Margiett Gil on 12/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppleStock: Codable {
    
    let open: Double
    let close: Double
    let date: String
    let label: String
    
    //MARK: Sections and Sorting
    static func getAppleStock() -> [[AppleStock]]{
        let appleStockVC = AppleStock.getStocks()
        
        
        let sortedData = appleStockVC.sorted {$0.date < $1.date}
        let sectionNames : Set<String> = Set(sortedData.map {($0.date)})
        
        var sections = Array(repeating: [AppleStock](), count: sectionNames.count)
        
        var currentIndex = 0
        var currentSection = sortedData.first?.date ?? nil
        
        for stock in sortedData {
            if stock.date == currentSection {
                sections[currentIndex].append(stock)
            } else {
                currentIndex += 1
                currentSection = stock.date
                sections[currentIndex].append(stock)
            }
        }
        return sections
    }
}

extension AppleStock {
    static func
        getStocks() -> [AppleStock] {
        
        var appleStockInfo = [AppleStock]()
        
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else{
            fatalError("unable to locate the json file ")
        }
        
        do{
            let data = try Data(contentsOf: fileURL)
            let appleStockData = try JSONDecoder().decode([AppleStock].self, from: data)
            appleStockInfo = appleStockData
            
            // why is not leting me sort appleStockData ???????????????????????
            // appleStockInfo = appleStockData.sorted {$0.date < $1.date}
            
        } catch {
            fatalError("\(error)")
        }
        return appleStockInfo
    }
}

