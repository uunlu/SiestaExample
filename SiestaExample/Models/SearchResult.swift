//
//  SearchResult.swift
//  SiestaExample
//
//  Created by Ugur Unlu on 1/19/19.
//  Copyright © 2019 Ugur Unlu. All rights reserved.
//

import Foundation

struct SearchResults<T: Decodable>: Decodable {
    let items: [T]
    init?(json:Any) {
        if let data = try? JSONSerialization.data(withJSONObject: json, options: []){
            guard let me = try? JSONDecoder().decode(T.self, from: data)
                else { return nil}
            self = me as! SearchResults<T>
        }else{
            items = []
        }
    }
}

struct SearchResult: Codable {
    let businesses: [Business]?
    let total: Int?
    let region: Region?
    
    
//    init?(json:Any) throws{
//        if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
//            guard let me = try? JSONDecoder().decode(SearchResult.self, from: data) else { return nil }
//            self = me
//        }else{
//            businesses = nil
//            total = 1
//            region = nil
//        }
//    }
}

struct Business: Codable {
    let id, alias, name: String?
    let imageURL: String?
    let isClosed: Bool?
    let url: String?
    let reviewCount: Int?
    let categories: [Category]?
    let rating: Double?
    let coordinates: Center?
    let transactions: [String]?
    let price: Price?
    let location: Location?
    let phone, displayPhone: String?
    let distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, coordinates, transactions, price, location, phone
        case displayPhone = "display_phone"
        case distance
    }

}

struct Category: Codable {
    let alias, title: String?
}

struct Center: Codable {
    let latitude, longitude: Double?
}

struct Location: Codable {
    let address1: String?
    let address2, address3: String?
    let city: String?
    let zipCode: String?
    let country: String?
    let state: String?
    let displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
    }
}

enum Price: String, Codable {
    case empty = "$$"
    case price = "$"
}

struct Region: Codable {
    let center: Center?
}

