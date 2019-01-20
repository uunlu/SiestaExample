//
//  SearchResultDTO.swift
//  SiestaExample
//
//  Created by Ugur Unlu on 1/20/19.
//  Copyright © 2019 Ugur Unlu. All rights reserved.
//

import Foundation

struct SearchResultDTO {
    let businesses: [BusinessDTO]
    let total: Int
    let region: RegionDTO?
    
    init(businesses:[BusinessDTO]?, total:Int?, region: RegionDTO?) {
        self.businesses = businesses ?? []
        self.total = total ?? 0
        self.region = region
    }
}

struct BusinessDTO {
    let name: String
    let imageURL: String
    
    init(name:String?, imageURL:String?){
        self.name = name ?? "N/A"
        self.imageURL = imageURL ?? ""
    }
}

struct RegionDTO {
    let latitude, longitude: Double
    
    init(latitude: Double?, longitude:Double?){
        self.latitude = latitude ?? 0
        self.longitude = longitude ?? 0
    }
}

