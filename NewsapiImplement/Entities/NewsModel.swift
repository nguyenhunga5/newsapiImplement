//
//  NewsModel.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsModel : NSObject, Mappable {

    var author : String?
    var content : String?
    var descriptionField : String?
    var publishedAt : String?
    var source : SourceModel?
    var title : String?
    var url : String?
    var urlToImage : String?


    class func newInstance(map: Map) -> Mappable? {
        return NewsModel()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        author <- map["author"]
        content <- map["content"]
        descriptionField <- map["description"]
        publishedAt <- map["publishedAt"]
        source <- map["source"]
        title <- map["title"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]   
    }
}
