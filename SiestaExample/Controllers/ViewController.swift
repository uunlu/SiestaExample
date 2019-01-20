//
//  ViewController.swift
//  SiestaExample
//
//  Created by Ugur Unlu on 1/19/19.
//  Copyright © 2019 Ugur Unlu. All rights reserved.
//

import UIKit
import Siesta

class ViewController: UIViewController {
    
    // MARK: Variables
    
    let _api = API.sharedInstance
    var model:ViewModel?
    var searchResultResource:Resource?{
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            oldValue?.cancelLoadIfUnobserved()
            
            searchResultResource?.addObserver(self).loadIfNeeded()
        }
    }

    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    // MARK: Helpers
    
    func setup() {
        self.searchResultResource = _api.search(location: "Miami", term: "pizza")
    }
}

// MARK: ViewModel Data Update Delegate

extension ViewController: ViewModelDelegate {
    func didSetModel<T>(model: T) where T : Any {
        guard let model = model as? SearchResultDTO else { return }
        print(model)
    }
}

// MARK: Siesta Resource Observer Delegate

extension ViewController:ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        self.model = ViewModel(model: resource, delegate: self)
        self.model?.delegate = self
    }
}


