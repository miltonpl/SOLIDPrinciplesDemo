//
//  NetworkClient.swift
//  SOLID Principles Demo
//
//  Created by Milton Palaguachi on 12/29/20.
//

import Foundation
import Alamofire
class NetworkCleint {
    func requestAPI(_ urlRequest: URLRequest) {
        AF.request(urlRequest).validate().responseJSON { response in
            guard let result = response.value  as? [[String: Any]] else { return }
            for item in result {
                print(item["userId"] as? Int ?? 0)
            }
        }
    }
    
}
