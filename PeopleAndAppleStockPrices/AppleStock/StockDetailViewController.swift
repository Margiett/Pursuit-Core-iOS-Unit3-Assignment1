//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Margiett Gil on 12/12/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

 @IBOutlet weak var stockImage: UIImageView!
 @IBOutlet weak var openLabel: UILabel!
 @IBOutlet weak var closeLabel: UILabel!
 
    var stock: AppleStock?
 
 
 override func viewDidLoad() {
     super.viewDidLoad()
    loadDataDVC()
    
 }
    func loadDataDVC() {
        guard let currentStock = stock else {
            fatalError("loadDataDVC did not work")
        }
        
        openLabel.text = currentStock.open.description
        closeLabel.text = currentStock.close.description
        
        //MARK: Changing the background color & image TODO's
        //If the stock price went up that day, set the background color to green and make the image a thumbs up.
        
        //If the stock price went down that day, set the background color to red and make the image a thumbs down
        
        if currentStock.open < currentStock.close {
            view.backgroundColor = .green
            stockImage.image = UIImage(named: "thumbsUP")
            
        } else {
            view.backgroundColor = .black
            stockImage.image = UIImage(named: "thumbsdown")
        }
    }

 

}
