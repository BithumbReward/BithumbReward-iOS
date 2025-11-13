//
//  BithumbAPI.swift
//  BitthumbReward
//
//  Created by kangho on 11/12/25.
//

import Foundation

/// JWT 토큰이 필요한 자산현황, 주문 리스트 조회, 주문 API
enum BithumbPrivateAPI {
    
    /// 주문
    case order(OrderRequest)
    
    /// 주문 리스트 조회
    case orders(OrderFetchRequest)
    
    /// 자산 현황
    case accounts
}

extension BithumbPrivateAPI: Endpoint {
    var baseURL: String {
        Environment.baseURL.absoluteString
    }
    
    var method: HTTPMethod {
        switch self {
        case .order: .post
        case .accounts, .orders: .get
        }
    }
    
    var path: String {
        switch self {
        case .order, .orders: return "orders"
        case .accounts: return "accounts"
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .order(let orderRequest): return nil
            
        case .orders(let orderFetchRequest):
            var items: [URLQueryItem] = [
                .init(name: "market", value: orderFetchRequest.market),
                .init(name: "state", value: orderFetchRequest.state),
                .init(name: "page", value: "\(orderFetchRequest.page)"),
                .init(name: "limit", value: "\(orderFetchRequest.limit)"),
                .init(name: "order", value: "\(orderFetchRequest.orderBy.description)"),
            ]
            
            let uuids = orderFetchRequest.uuids.map {
                URLQueryItem(name: "uuid[]", value: $0)
            }
            
            return items + uuids
        case .accounts: return nil
        }
    }
    
    var body: (any Encodable)? {
        switch self {
        case .order(let orderRequest): return orderRequest
        case .orders: return nil
        case .accounts: return nil
        }
    }
    
    var needAuth: Bool { true }
}
