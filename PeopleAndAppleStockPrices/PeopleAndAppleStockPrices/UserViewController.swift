//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

enum SearchScope {
    case fullName
    case city
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var didSetUser = [UserInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: This is holding the search plus allowing the user to switch from searching from full name to city
   // var currentScope = SearchScope.fullName

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    func loadData() {
        didSetUser = User.getUser()
    }
    
    //MARK: To make the search bar work
    func searchFilter(for searchText: String) {
        guard !searchText.isEmpty else {
                   return
               }
        didSetUser = User.getUser().filter { $0.name.first.contains(searchText.lowercased())}
    }
  

    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userDetail = segue.destination as? DetailUserViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("segue did not work")
        }
        userDetail.userInfo = didSetUser[indexPath.row]
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
        
        //MARK: title and subtitle
        let fullName = ("\(userFirstName) \(userLastName)").capitalized
        cell.textLabel?.text = fullName.capitalized
        cell.detailTextLabel?.text = userInfo.location.city.capitalized
        
        return cell
    }
}
//MARK: Search Bar / Delegate !
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        searchFilter(for: searchText)
        
    }
    
}

