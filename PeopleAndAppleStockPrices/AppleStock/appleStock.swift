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
    
    //MARK: Computed property
    // this code right here is allowing me to show in the header the month and the year
    var sectionHeader: String {
        // this code seprated them
        var monthYear = label.components(separatedBy: " ")
        // this code removed the day
        monthYear.remove(at: 1)
        // this code right here display the month and the year and it separates it with a space
        return monthYear.joined(separator: " ") // Sept 1 17 => Sep 17
    }
    
    //MARK: Sections and Sorting
    static func getAppleStock() -> [[AppleStock]]{
    //let stocks = getStocks()
    var monthTitles = Set<String>()
    let stockSelection = getStocks()
        
        // This code is suppose to take away the day of the sections so only the month and the year pops up
        for appleStockInfo in stockSelection {
            var label = appleStockInfo.label
            var monthYear = label.components(separatedBy: " ")
            monthYear.remove(at: 1)
            label = monthYear.joined()
            monthTitles.insert(label)
        }
        
        let sortedData = stockSelection.sorted {$0.date < $1.date}
        let sectionNames = Set(sortedData.map {($0.date)}) // unsure if i need this code
        
        var sections = Array(repeating: [AppleStock](), count: sectionNames.count)
        
        var currentIndex = 0
        var sectionIndex = 0
        var currentSection = sortedData.first?.date ?? nil
        
        for stock in sortedData {
            if stock.date == currentSection {
                sections[currentIndex].append(stock)
            } else {
                currentIndex += 1
                sectionIndex += 1
                currentSection = stock.date
                sections[currentIndex].append(stock)
            }
        }
        return sections
    }
}

extension AppleStock {
    static func getStocks() -> [AppleStock] {
        
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

