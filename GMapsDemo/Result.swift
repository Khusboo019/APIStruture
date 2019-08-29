//
//  Result.swift
//  Satapana_Profitto
//
//  Created by 2130 on 4/15/19.
//  Copyright © 2019 JMRInfotech. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
