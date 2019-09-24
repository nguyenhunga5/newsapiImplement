//
//  NewsService.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/24/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import Alamofire

class NewsService: BaseService {
    
    typealias NewsCallback = (_ news: [NewsModel]?, _ status: ResponseModel.Status, _ code: ResponseModel.Code?, _ message: String?) -> Void
    
    class NewsRequest {
        let query: String
        var totalNews: Int
        var currentPage: Int
        var pageSize: Int

        public init(query: String, pageSize: Int = 20, totalNews: Int, currentPage: Int) {
            self.query = query
            self.totalNews = totalNews
            self.currentPage = currentPage
            self.pageSize = pageSize
        }
        
        func calculatorForReload() {
            currentPage = 1
            totalNews = 0
        }
        
        func canLoadMore() -> Bool {
            return currentPage * pageSize < totalNews
        }
        
        func calculatorForLoadMore() {
            currentPage += 1
        }
    }
    
    enum NewsEnpoint: EndPoint {
        case topHeadline(request: NewsRequest)
        case customSearch(request: NewsRequest)
        
        var serializers: String {
            let str: String
            switch self {
            case .topHeadline(let request):
                str = "/top-headlines?country=\(request.query)&pageSize=\(request.pageSize)&page=\(request.currentPage)"
            
            case .customSearch(let request):
                str = "/everything?q=\(request.query)&pageSize=\(request.pageSize)&page=\(request.currentPage)"
            }
            
            return str
        }
    }
    
    func topHeadline(_ request: NewsRequest, complete: @escaping NewsCallback) {
        self.objectResponseRequest(.get, endPoint: NewsEnpoint.topHeadline(request: request)) { (response: DataResponse<ResponseModel>) in
            if let response = response.value {
                request.totalNews = response.totalResults
                complete(response.articles, response.status ?? .error, response.code, response.message)
                
            } else {
                complete(nil, .error, .unexpectedError, nil)
            }
        }
    }
    
    func customSearch(_ request: NewsRequest, complete: @escaping NewsCallback) {
        self.objectResponseRequest(.get, endPoint: NewsEnpoint.customSearch(request: request)) { (response: DataResponse<ResponseModel>) in
            if let response = response.value {
                request.totalNews = response.totalResults
                complete(response.articles, response.status ?? .error, response.code, response.message)
                
            } else {
                complete(nil, .error, .unexpectedError, nil)
            }
        }
    }
}
