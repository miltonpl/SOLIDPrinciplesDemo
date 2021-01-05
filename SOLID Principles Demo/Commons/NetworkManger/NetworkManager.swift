//
//  NetworkManager.swift
//  SOLID Principles Demo
//
//  Created by Milton Palaguachi on 12/29/20.
//
/*
 S - Single-responsiblity Principle
 O - Open-closed Principle
 L - Liskov Substitution Principle
 I - Interface Segregation Principle
 D - Dependency Inversion Principle
 */
/*
 Single-Responsibility Principle
 Single-responsibility Principle (SRP) states:

 A class should have one and only one reason to change, meaning that a class should have only one job
 */

import UIKit
enum NetworkError: Error {
    case invalidURL
    case server(Error)
    case httpResponse(String)
    case unknown
    case jsonDecoderFail
    case jsonSerializationFail
    case description(String)
}

public class NetworkManager {
    
    // MARK: - Properties
    private let session: URLSession
    
    // MARK: - Init
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Methods
    func request(endpoint: EndPoint,complitionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = endpoint.url else { return complitionHandler(.failure(.invalidURL)) }
        //Url Session Task creation
        print("url\(url)")
        session.dataTask(with: url) { data, response, error in
            
            let result: Result<Data, NetworkError>
            
            if let error = error {
                result = .failure(.server(error))
            } else if let data = data {
                result = .success(data)
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode > 299 || httpResponse.statusCode < 200 {
                    result = .failure(.httpResponse("HTTP Status Code not in range [200..299],but is \(httpResponse.statusCode)"))
                } else {
                    result = .failure(.unknown)
                }
            }
            else {
                result = .failure(.unknown)
            }
            complitionHandler(result)
        }.resume()
    }
}
