//
//  ParserJsonDecoder.swift
//  SOLID Principles Demo
//
//  Created by Milton Palaguachi on 12/30/20.
//

import Foundation

class ParserJsonDecoder {
    
    let networkManager:NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
   
    func parser<T: Decodable>(forType type: T.Type, completion: @escaping(Result<T, NetworkError>)->Void) {
        self.networkManager.request(endpoint: .search(matching: "House")) { result in
            DispatchQueue.global().async {
                
                var value:Result<T,NetworkError>
                switch result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(type.self, from: data)
                        value = .success(jsonData)
                    } catch {
                        value = .failure(.jsonDecoderFail)
                    }
                    
                case .failure(let error):
                    value = .failure(error)
                }
                
                DispatchQueue.main.async {
                    completion(value)
                }
            }
        }
    }
}
