//
//  user.swift
//  PeopleAndAppleStockPrices
//
//  Created by Margiett Gil on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct User: Codable {
    let results: [UserInfo]
}

struct UserInfo: Codable {
    let name: UserName
    let location: Address
    let email: String
    let picture: Picture
    
}

struct UserName: Codable {
    var title: String
    var first: String
    var last: String
}
               
struct Address: Codable {
    var city: String
    var country: String
    
}

struct Street: Codable {
    let number: Int
    let name: String
}


struct Picture: Codable {
    let medium: String
}

extension User {
    static func getRandomUser() -> [UserInfo] {
        var userExtension = [UserInfo]()

        // what does Bundle.main do ????
        guard let fileURL = Bundle.main.url(forResource: "RandomUser", withExtension: "json") else {
            fatalError("there is an issue with the url")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let userData = try JSONDecoder().decode(User.self, from: data)
            userExtension = userData.results
        } catch {
            print("there is an issue \(error)")
        }
        return userExtension
    }
}
