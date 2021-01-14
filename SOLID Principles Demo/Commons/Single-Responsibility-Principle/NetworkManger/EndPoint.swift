//
//  EndPoint.swift
//  SOLID Principles Demo
//
//  Created by Milton Palaguachi on 12/29/20.
//

import Foundation
enum Sorting: String {
    case numOfStars = "stars"
    case numberOfForks = "forks"
    case recency = "updated"
}

struct EndPoint {
    let path: String
    let queryItems: [URLQueryItem]
    var header: [String: String]?
}

extension EndPoint {
    static func search(matching query: String) -> EndPoint {
        return EndPoint(
            path: "/api/v1/images/search",
            queryItems: [
            URLQueryItem(name: "query", value: query),
        ])
    }
    
    var url: URL? {
        var componets = URLComponents()
        componets.scheme = "http"
        componets.host = "www.splashbase.co"
        componets.path = path
        componets.queryItems = queryItems
        return componets.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        if let header = self.header {
            urlRequest.allHTTPHeaderFields = header
        }
        return urlRequest
    }
}

