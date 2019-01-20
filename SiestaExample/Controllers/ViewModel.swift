//
//  ViewModel.swift
//  SiestaExample
//
//  Created by Ugur Unlu on 1/20/19.
//  Copyright © 2019 Ugur Unlu. All rights reserved.
//

import Foundation
import Siesta

protocol ViewModelDelegate {
    func didSetModel<T:Any>(model:T)
}

class ViewModel {
    var model: SearchResultDTO?
    var delegate: ViewModelDelegate?
    
    init(model: Resource?, delegate: Any) {
        if let data:SearchResult = model?.typedContent() {
            self.delegate = delegate as? ViewModelDelegate
            mapModelToDTO(model: data)
            self.delegate?.didSetModel(model: self.model)
        }
    }
    
    private init(){
        
    }
    
    func mapModelToDTO(model:SearchResult) {
        var businessesDto:[BusinessDTO]?
        var regionDTO: RegionDTO?
        if let businesses = model.businesses {
            businessesDto = businesses.flatMap({ (business) -> [BusinessDTO] in
                return [BusinessDTO(name: business.name, imageURL: business.imageURL)]
            })
        }
        
        if let region = model.region {
            regionDTO = RegionDTO(latitude: region.center?.latitude, longitude: region.center?.longitude)
        }
        
        self.model = SearchResultDTO(businesses:businessesDto, total: model.total, region: regionDTO)
        
    }
}
