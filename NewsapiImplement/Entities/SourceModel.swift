//
//  SourceModel.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import ObjectMapper

class SourceModel : NSObject, Mappable {

    var id : String?
    var name : String?


    class func newInstance(map: Map) -> Mappable?{
        return SourceModel()
    }
    
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        
    }
}
