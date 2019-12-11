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
    
    //MARK: DidSet property observer,
    var appleStockVC = [AppleStock](){
        didSet {
            tableView.reloadData()
        }
    }
    
    var sections = AppleStock()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
    }
    func loadData {
        appleStockVC = AppleStock.getStocks()
        
        let 
    }
    
    
    
}
