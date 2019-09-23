//
//  BaseService.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

fileprivate let apiUrl = "https://newsapi.org/v2"
fileprivate let apiKey = "4ddb56fbbba5428c9831a66b9336336b"

protocol EndPoint {
    var serializers: String {get}
    func encoded() -> String
}

extension EndPoint {
    
    func encoded() -> String {
        var requestUrl = apiUrl + self.serializers
        
        if requestUrl.range(of: "?") != nil {
            requestUrl += "&apiKey=" + apiKey
        } else {
            requestUrl += "?apiKey=" + apiKey
        }
        
        return requestUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? requestUrl
    }
}

class BaseService: NSObject {
    
    enum StatusCode : Int {
        case success            =       200
        case created            =       201
        case noInternet         =       400
        case unauthorized       =       401
        case forbidden          =       403
        case notFound           =       404
        case requestTimeout     =       408
        case conflict           =       409
        case gone               =       410
        case internalError      =       500
        case unknown            =       520
        case internetOffline    =       417
        
        static func parse(code: Int?) -> StatusCode {
            return StatusCode(rawValue: code ?? 404) ?? .notFound
        }
    }
    
    @discardableResult
    func baseRequest(_ method: Alamofire.HTTPMethod, endPoint: EndPoint,
                     headers: HTTPHeaders? = nil,
                     params: Parameters? = nil,
                     encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest {
        
        var sendHeaders: HTTPHeaders
        if let headers = headers {
            sendHeaders = headers
        } else {
            sendHeaders = HTTPHeaders()
        }
        
        if sendHeaders["Accept"] == nil {
            sendHeaders["Accept"] = "application/json"
        }
        
        let request = Alamofire.request(endPoint.encoded(), method: method,
                                 parameters: params,
                                 encoding: encoding,
                                 headers: sendHeaders)
        return request
    }
    
    @discardableResult
    func objectResponseRequest<T: BaseMappable>(_ method: Alamofire.HTTPMethod, endPoint: EndPoint,
                             headers: HTTPHeaders? = nil,
                             params: Parameters? = nil,
                             encoding: ParameterEncoding = JSONEncoding.default,
                             completionHandler: @escaping (DataResponse<T>) -> Void) -> DataRequest {
        
        let request = baseRequest(method, endPoint: endPoint, headers: headers, params: params, encoding: encoding)
        
        request.responseObject(completionHandler: completionHandler)
        return request
    }
    
    @discardableResult
    func arrayResponseRequest<T: BaseMappable>(_ method: Alamofire.HTTPMethod, endPoint: EndPoint,
                                                headers: HTTPHeaders? = nil,
                                                params: Parameters? = nil,
                                                encoding: ParameterEncoding = JSONEncoding.default,
                                                completionHandler: @escaping (DataResponse<[T]>) -> Void) -> DataRequest {
        
        let request = baseRequest(method, endPoint: endPoint, headers: headers, params: params, encoding: encoding)
        
        request.responseArray(completionHandler: completionHandler)
        
        return request
    }
}
