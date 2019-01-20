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
    func didSetModel<T:Decodable>(model:T)
}

class ViewModel {
    var model: SearchResult?
    var delegate: ViewModelDelegate?
    
    init(model: Resource?, delegate: Any) {
        if let data:SearchResult = model?.typedContent() {
            self.delegate = delegate as? ViewModelDelegate
            self.delegate?.didSetModel(model: data)
        }
    }
    
    private init(){
        
    }
}
