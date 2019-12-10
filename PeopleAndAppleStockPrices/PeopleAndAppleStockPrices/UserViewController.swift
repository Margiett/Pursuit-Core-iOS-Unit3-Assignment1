//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var didSetUser = [UserInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    func loadData() {
        didSetUser = User.getUser()
      
}
    func searchFilter(for searchText: String) {
        didSetUser = User.getUser().filter { $0.name.first.contains(searchText.lowercased())}
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userDetail = segue.destination as? DetailUserViewController, let indexPath = tableView.indexPathsForSelectedRows else {
        fatalError("segue did not work")
    }
    }
}

    extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return didSetUser.count
        }

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            
            let userInfo = didSetUser[indexPath.row]
            
            //MARK: calling the first and Last name !
            let userFirstName = userInfo.name.first ?? ""
            let userLastName = userInfo.name.last ?? ""
            
            let fullName = ("\(userFirstName.capitalized) \(userLastName.capitalized)")
            
            cell.textLabel?.text = fullName.capitalized
            cell.detailTextLabel?.text = userInfo.location.city.capitalized
            
            return cell
        }
}
extension ViewController: UISearchBarDelegate {
    func searchBarExtension(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchFilter(for: searchText)
    }
    
}

