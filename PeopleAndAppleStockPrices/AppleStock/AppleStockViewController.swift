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
    //var emptyArr = [String]()
    
    //MARK: DidSet property observer,
     var emptyStockArray = [[AppleStock]](){
        didSet {
            tableView.reloadData()
        }
    }
    
//    var sections = [AppleStock]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
    }
   func loadData() {
   emptyStockArray = AppleStock.getAppleStock()
    }
    
    func getAvg(for arr: [AppleStock]) -> Double {
        var sum = 0.0 // because the open and close label are doubles
        var average = 0.0 // because the open and close label are doubles
        for stock in arr {
            sum += stock.open
        }
        
        average = sum / Double(arr.count)
        return average
    }
       
//
//    //

    
    
    //MARK: Prepare for segue to DetailViewController 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let stockVC = segue.destination as? StockDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            return
            
        }
    // guard variable detailVC variable view controller variable plus indexPath.section and indexPAth.row
        stockVC.stock = emptyStockArray[indexPath.section][indexPath.row]
    }

      
  }

//this tells how many rows i want in each section
extension AppleStockViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emptyStockArray[section].count
    }
    
    //This function should put information into my cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = emptyStockArray[indexPath.section][indexPath.row]
        
     cell.textLabel?.text = stock.date
     cell.detailTextLabel?.text = stock.open.description
        
        return cell
    }
    
//MARK: - method needed to implement sections
 func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         
    return emptyStockArray[section].first?.sectionHeader
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return emptyStockArray.count // this just counts the arrays
        
}
    
}
