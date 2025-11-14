//
//  RequestBuilder.swift
//  BitthumbReward
//
//  Created by kangho on 11/14/25.
//

import Foundation

struct RequestBuilder {
    
    func build<E: Endpoint>(_ endpoint: E) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: endpoint.baseURL) else {
            throw URLError(.badURL)
        }
        
        urlComponents.path += endpoint.path
        urlComponents.queryItems = endpoint.queries
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json",
                                         forHTTPHeaderField: "Content-Type")
        }
        
        let queryString = urlComponents.percentEncodedQuery ?? ""
        
        if endpoint.needAuth {
            let token = try JWT.generate(accessKey: AppConfiguration.accessKey, secretKey: AppConfiguration.secretKey, query: queryString)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
