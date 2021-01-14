//
//  ParserJsonSerialization.swift
//  SOLID Principles Demo
//
//  Created by Milton Palaguachi on 1/3/21.
//

import Foundation

class ParserJsonSerialization {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
   
    func parser(query: String, completion: @escaping(Result<[PhotoProtocol], NetworkError>) -> Void)  {
        
        self.networkManager.request(endpoint: .search(matching: query)) {[weak self] result in
            var value: Result<[PhotoProtocol], NetworkError>
            switch result {
            case .success(let data):
                do {
                    let parseJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    guard let dictionary = parseJson as? [String: Any], let weakSelf = self else {
                        return completion(.failure(.description("data not dictionary[String: Any] ")))
                    }
                    
                    value = try .success((weakSelf.fromDictionaryToArray(dictionary: dictionary)))
                } catch {
                    value = .failure(.description("\(error.localizedDescription)"))
                }
                
            case .failure(let error):
                value = .failure(error)
            }
            completion(value)
        }
    }
    
    func fromDictionaryToArray(dictionary: [String: Any])throws -> [PhotoProtocol] {
        
        guard let items = dictionary["images"] as? [NSDictionary] else {
            throw NetworkError.description(#""/images/" in dictionary does not exit"#)
            
        }
        var photos = [PhotoProtocol]()
        items.forEach { item in
            let photo = Photo(dictionary: item)
            photos.append(photo)
        }
        return photos
    }
}
