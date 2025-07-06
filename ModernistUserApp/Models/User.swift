//
//  User.swift
//  ModernistUserApp
//
//  Created by Berkay Emre Aslan on 1.07.2025.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    // Profil fotoğrafı için computed property
    var profileImageURL: String {
        "https://picsum.photos/200/200?random=\(id)"
    }
    
    static let mockUser = User(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "sincere@april.biz",
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            address: Address.mockAddress,
            company: Company.mockCompany
        )
}

struct Address: Codable, Hashable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    var fullAddress: String {
        "\(street), \(suite), \(city) \(zipcode)"
    }
    
    static let mockAddress = Address(
            street: "Kulas Light",
            suite: "Apt. 556",
            city: "Gwenborough",
            zipcode: "92998-3874",
            geo: Geo.mockGeo
        )
}

struct Geo: Codable, Hashable {
    let lat: String
    let lng: String
    
    static let mockGeo = Geo(
           lat: "-37.3159",
           lng: "81.1496"
       )
}

struct Company: Codable, Hashable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    static let mockCompany = Company(
            name: "Romaguera-Crona",
            catchPhrase: "Multi-layered client-server neural-net",
            bs: "harness real-time e-markets"
        )
}


