//
//  Endpoint.swift
//  Satapana_Profitto
//
//  Created by 2130 on 4/15/19.
//  Copyright © 2019 JMRInfotech. All rights reserved.
//

import Foundation
import UIKit

protocol Endpoint {
    var base:  String { get }
    var path: String { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents? {
        guard var components = URLComponents(string: base) else { return nil }
        components.path = path
        return components
    }
    
    var request: URLRequest? {
        guard let url = urlComponents?.url ?? URL(string: "\(self.base)\(self.path)") else { return nil }
        let request = URLRequest(url: url)
        return request
    }
    
    func getRequest(headers: [HTTPHeader]) -> URLRequest? {
        
        guard var request = self.request else { return nil }
        request.httpMethod = HTTPMethod.get.rawValue
        headers.forEach { request.addValue($0.header.value, forHTTPHeaderField: $0.header.field)}
        
        return request
        
    }
    
    func postRequest<T: Encodable>(parameters: T, headers: [HTTPHeader]) -> URLRequest? {
        
        guard var request = self.request else { return nil }
        request.httpMethod = HTTPMethod.post.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch let error {
            print(APIError.postParametersEncodingFalure(description: "\(error)").customDescription)
            return nil
        }
        headers.forEach { request.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        return request
    }
    
}
