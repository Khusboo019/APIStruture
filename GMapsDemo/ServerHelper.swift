//
//  ServerHelper.swift
//  GMapsDemo
//
//  Created by 2130 on 8/29/19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation
import UIKit

class GenericAPIClients: GenericAPIClient {
    
    internal let session: URLSession
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //MARK: Post
    
    func userLogin(authenticationEncodable:AuthenticationEncodable?, completion: @escaping (Result<AuthenticationResponse?, APIError>) -> ()) {
//        print("+++++++++++")
//        print(authenticationEncodable)
        guard let request = BaseApiFeed.userLogin.postRequest(parameters: authenticationEncodable,
                                                              headers: [HTTPHeader.contentType("application/json;charset=utf-8")]) else { return }
        fetch(with: request , decode: { json -> AuthenticationResponse? in
            guard let results = json as? AuthenticationResponse else { return  nil }
            return results
        }, completion: completion)
}
    
    //MARK: get
    func getSelectBoxDropdown(from authToken:String, completion: @escaping (Result<GdbGeneralResponse?, APIError>) -> Void) {
        
        guard let request = BaseApiFeed.userLogin.getRequest(headers: [HTTPHeader.authorization(authToken)]) else { return }
        
        fetch(with: request, decode: { json -> GdbGeneralResponse? in
            guard let getFeedResult = json as? GdbGeneralResponse else { return  nil }
            return getFeedResult
        }, completion: completion)
    }
}

