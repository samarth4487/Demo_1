//
//  Food.swift
//  Sample
//
//  Created by Samarth Paboowal on 01/02/18.
//  Copyright © 2018 Samarth Paboowal. All rights reserved.
//

import Foundation
import ObjectMapper

class APIResponse: Mappable {
    
    var collections: [FoodCollections]?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        collections     <- map["collections"]
    }
}

class FoodCollections: Mappable {
    
    var collection: FoodCollection?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        collection      <- map["collection"]
    }
}

class FoodCollection: Mappable {
    
    var collection_id: Int?
    var res_count: Int?
    var image_url: String?
    var url: String?
    var title: String?
    var description: String?
    var share_url: String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        collection_id    <- map["collection_id"]
        res_count       <- map["res_count"]
        image_url       <- map["image_url"]
        url            <- map["url"]
        title           <- map["title"]
        description      <- map["description"]
        share_url        <- map["share_url"]
    }
}

