//
//  BithumbPublicAPI.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

/// 빗썸 코인 종목, 시헤 조회 API
enum BithumbPublicAPI {
    /// 종목 조회
    case market
    /// 현재 시세 조회
    case ticker(markets: [String])
}

extension BithumbPublicAPI: Endpoint {
    var baseURL: String {
        Environment.baseURL.absoluteString
    }
    
    var method: HTTPMethod {
        switch self {
        case .market, .ticker:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .market: "market/all"
        case .ticker: "ticker"
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .market: return []
        case .ticker(let markets):
            let params = markets.joined(separator: ",")
            return [URLQueryItem(name: "markets", value: params)]
        }
    }
    
    var body: (any Encodable)? { nil }
    
    var needAuth: Bool { false }
}
