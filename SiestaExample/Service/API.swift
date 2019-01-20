//
//  API.swift
//  SiestaExample
//
//  Created by Ugur Unlu on 1/19/19.
//  Copyright © 2019 Ugur Unlu. All rights reserved.
//

import Foundation
import Siesta


class API {
    static let sharedInstance = API()
    
    private enum Yelp {
        static let key = "BIqwAtowA8j7TVgFJOPfyrvyJ0QY90ebJmB1woW2LzQjr8mV3JEdeqpL6bWABz4R4AeDGuxQdg0aUag9LROZOyXW803SleCDxXQwx2H3R4X6eSiDDI6gcSvCWkdDXHYx"
    }
    
    private let service = Service(baseURL: "https://api.yelp.com/v3", standardTransformers: [.text, .json])
    
    private init() {
        #if DEBUG
        // Bare-bones logging of which network calls Siesta makes:
        SiestaLog.Category.enabled = .all
        #endif
        
        // –––––– Global configuration ––––––
        let jsonDecoder = JSONDecoder()

        service.configure("**") {
            $0.headers["Authorization"] = "Bearer \(Yelp.key)"
            $0.headers["Content-Type"] = "application/json;charset=UTF-8"
            $0.headers["Accept"] = "application/json;charset=UTF-8"
            // Disable default Siesta transformer
            $0.pipeline[.parsing].removeTransformers()
        }
        
        service.configureTransformer("/businesses/search") {
            try jsonDecoder.decode(SearchResult.self, from: $0.content)
        }
    }
    
    // MARK: API Endpoints
    
    func search(location:String, term:String) -> Resource {
        return service
            .resource("/businesses/search")
            .withParam("location", location)
            .withParam("term", term)
    }
}
