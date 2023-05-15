//
//  Request.swift
//  20230512-VibhorSingla-NYCSchools
//
//  Created by Vibhor Singla on 12/05/23.
//

import Foundation
struct Request {
    var url: URL
    var method: HttpMethods
    var requestBody: Data? = nil

    public init(withUrl url: URL, forHttpMethod method: HttpMethods, requestBody: Data? = nil) {
        self.url = url
        self.method = method
        self.requestBody = requestBody != nil ? requestBody : nil
    }
}
