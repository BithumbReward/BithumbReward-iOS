//
//  Endpoint.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var queries: [URLQueryItem]? { get }
    var body: Encodable? { get }
    
    /// JWT 필요 여부
    var needAuth: Bool { get }
}
