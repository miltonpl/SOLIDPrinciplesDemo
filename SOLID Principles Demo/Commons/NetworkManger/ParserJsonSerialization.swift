//
//  ParserJsonSerialization.swift
//  SOLID Principles Demo
//
//  Created by Milton Palaguachi on 1/3/21.
//

import Foundation

class ParserJsonSerialization {
    
    let networkManager:NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
   
    func parser(query: String, completion: @escaping(Result<[PhotoProtocol], NetworkError>) -> Void)  {
        self.networkManager.request(endpoint: .search(matching: query)) { result in
            var value: Result<[PhotoProtocol], NetworkError>
            switch result {
            case .success(let data):
                do {
                    let parseJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    guard let dictionary = parseJson as? [String: Any], let items = dictionary["images"] as? [NSDictionary] else {
                        return completion(.failure(.description("data not dictionary[String: Any] or fail to find images dictionary[images] as? [NSDictonary]")))
                    }
                    
                    var photos = [PhotoProtocol]()
                    items.forEach { item in
                        let photo = Photo(dictionary: item)
                        photos.append(photo)
                    }
                    value = .success(photos)
                } catch {
                    value = .failure(.jsonSerializationFail)
                }
                
            case .failure(let error):
                value = .failure(error)
            }
            completion(value)
        }
    }
}
