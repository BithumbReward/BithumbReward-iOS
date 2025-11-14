//
//  HTTPClient.swift
//  BitthumbReward
//
//  Created by kangho on 11/14/25.
//

import Foundation

protocol HTTPClient {
    func send<T: Decodable>(_ request: URLRequest, decode: @escaping (Data) throws -> T) async throws -> T
}

extension URLSession: HTTPClient {
    func send<T: Decodable>(_ request: URLRequest, decode: @escaping (Data) throws -> T) async throws -> T {
        
        print("URL:", request.url?.absoluteString ?? "nil")
        print("Headers:", request.allHTTPHeaderFields ?? [:])

        let (data, response) = try await self.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        print("status:", httpResponse.statusCode)
        print("body:", String(data: data, encoding: .utf8) ?? "")
        
        if (200...299) ~= httpResponse.statusCode {
            return try decode(data)
        }
        throw URLError(.cannotParseResponse)
    }
}
