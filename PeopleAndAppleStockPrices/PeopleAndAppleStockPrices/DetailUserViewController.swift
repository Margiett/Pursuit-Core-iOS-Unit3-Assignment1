//
//  DetailUserViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Margiett Gil on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailUserViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCityLabel: UILabel!
    
    var userInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    func loadData() {
        guard let userDetail = userInfo else {
            return
        }
      
        userNameLabel.text = "\(userDetail.name.first.capitalized) \(userDetail.name.last.capitalized)"
        userEmailLabel.text = userDetail.email
        userCityLabel.text = userDetail.location.city.capitalized
        
        //MARK: Calling the Picture here !
       
        RandomUrlAPI.fetchRandomUser(endpointURLString: "\(userDetail.picture.medium)") { (result) -> () in
            switch result {
            case .failure(let error):
                let alertController = UIAlertController(title: "Network Error", message: "\(error)" , preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                    dump(error)
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.userImageView.image = UIImage.init(data: image)
                    
                    
                }
                
            }
        }
    }
}
