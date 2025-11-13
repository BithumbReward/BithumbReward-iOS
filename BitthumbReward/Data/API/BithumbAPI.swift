//
//  BithumbAPI.swift
//  BitthumbReward
//
//  Created by kangho on 11/12/25.
//

import Foundation

enum BithumbAPI {
    case order(dto: OrderRequest)
}

extension BithumbAPI {
    var baseURL: String {
        "https://api.bithumb.com/v1/"
    }
    
    var method: HTTPMethod {
        switch self {
        case .order(let dto):
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .order(let dto):
            return "orders"
        }
    }
    
    var header: [String: String] {
        return [:]
    }
}
