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
    case api(message: String)
    case status(String)
}

public class NetworkManager {
    
    // MARK: - Properties
    private let session: URLSession
    
    // MARK: - Init
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Methods
    func request(endpoint: EndPoint,completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = endpoint.url else { return completionHandler(.failure(.invalidURL)) }
      
        self.session.dataTask(with: url) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                 return completionHandler(.failure(.api(message: "\(error?.localizedDescription ?? " no error description")")))
            }
            switch response.statusCode {
            case 200...299:
                completionHandler(.success(data))
            default:
                completionHandler(.failure(.status("HTTP URL Response status in not in range 200..299 but is \(response.statusCode)")))
            }
        }.resume()
    }
}
