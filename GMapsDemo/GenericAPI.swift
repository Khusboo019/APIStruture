//
//  GenericAPI.swift
//  Satapana_Profitto
//
//  Created by 2130 on 4/15/19.
//  Copyright © 2019 JMRInfotech. All rights reserved.
//

import Foundation

protocol GenericAPIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}


extension GenericAPIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "No description"))
                return
            }
            guard httpResponse.statusCode == 200  else {
                completion(nil, .responseUnsuccessful(description: "\(httpResponse.statusCode)"))
                return
            }
            
            guard let data = data else { completion(nil, .invalidData); return }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data) as? [String:AnyObject] {
                    //print(responseJSON)
                }
                let genericModel = try JSONDecoder().decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch let err {
                print("==============")
                print(err)
                
                completion(nil, .jsonConversionFailure(description: "\(err.localizedDescription)"))
            }
        }
        return task
    }
    
    /// success respone executed on main thread.
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            
            DispatchQueue.main.async {
                
                guard let json = json else {
                    error != nil ? completion(.failure(.decodingTaskFailure(description: "\(String(describing: error))"))) : completion(.failure(.invalidData))
                    return
                }
                guard let value = decode(json) else { completion(.failure(.jsonDecodingFailure)); return }
                completion(.success(value))
            }
        }
        
        task.resume()
    }
}
