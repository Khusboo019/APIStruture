//
//  BaseAPI.swift
//  GMapsDemo
//
//  Created by 2130 on 8/29/19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation
enum BaseApiFeed {
    
    case userLogin
    
}

extension BaseApiFeed: Endpoint {
    
    var base: String {
       
        //192.168.9.35:8080
        return "http://192.168.9.40:1736/profitto/mobile/"
    }
    
    var path: String {
        
        switch self {
        //case .userLogin: return "user/login"
        case .userLogin: return "user/authenticate"
        
        }
    }
}


