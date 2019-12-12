//
//  AppleStockViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Margiett Gil on 12/11/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class AppleStockViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var emptyArr = [String]()
    //MARK: DidSet property observer,
    var appleStockVC = [AppleStock](){
        didSet {
            tableView.reloadData()
        }
    }
    
    var sections = [AppleStock]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
    }
   func loadData(){
          appleStockVC = AppleStock.getStocks()
          
          let sortedData = appleStockVC.sorted {$0.label < $1.label}
          let sectionNames : Set<String> = Set(sortedData.map {$0.date})
          sections = Array(repeating: appleStockVC, count: sectionNames.count)
          
          var currentIndex = 0
          var currentSection = sortedData.first?.date ?? ""
          
          for stock in sortedData {
              if stock.date == currentSection {
                  sections[currentIndex].append(stock)
              } else {
                  currentIndex += 1
                  currentSection = stock.date
                  sections[currentIndex].append(stock)
              }
          }
      }
      
  }


extension AppleStockViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return
            //sections[sections].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        //let stock = sections[indexPath.row][indexPath.sections]
        
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        
        return cell
    }
    
}
