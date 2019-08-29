//
//  Entity.swift
//  GMapsDemo
//
//  Created by 2130 on 8/29/19.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

struct AuthenticationEncodable:Codable{
    let profittoUser:ProfittoUser?
}

struct ProfittoUser:Codable {
    let userName:String?
    let password:String?
    let userId:Int64?
}

struct AuthenticationResponse : Codable{
    var reqSecureKey:String?
    var addiParams:[String]? = nil
   
}

struct GdbGeneralResponse:Codable {
    
}
