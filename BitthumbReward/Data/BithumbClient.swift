//
//  BithumbClient.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

public class BithumbClient {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}

// MARK: Public API

extension BithumbClient {
    
    /// market에서 거래되는 코인 목록 조회
    func markets() async throws -> [Market] {
        
        try await publicRequest(.market)
    }
    
    /// 입력한 마켓의 시세를 조회
    func ticker(_ markets: [String]) async throws -> [Ticker] {
        
        try await publicRequest(.ticker(markets: markets))
    }
}

// MARK: Private API

extension BithumbClient {
    
    /// 보유한 화폐의 매수평균가, 보유 금액 등 조회
    func account() async throws -> [Account] {
        try await privateRequest(.accounts)
    }
    
    /// 코인 주문 리스트 조회
    func fetchOrders(_ fetchOrder: OrderFetchRequest) async throws -> [Order] {
        try await privateRequest(.orderList(fetchOrder))
    }
    
    /// 코인 주문
    @discardableResult
    func order(_ orderRequest: OrderRequest) async throws -> Order {
        try await privateRequest(.order(orderRequest))
    }
}

extension BithumbClient {
    
    private func publicRequest<T: Decodable>(_ endpoint: BithumbPublicAPI) async throws -> T {
        let builder = RequestBuilder()
        let request = try builder.build(endpoint)
        return try await session.send(request) { try JSONDecoder().decode(T.self, from: $0) }
    }
    
    private func privateRequest<T: Decodable>(_ endpoint: BithumbPrivateAPI) async throws -> T {
        let builder = RequestBuilder()
        let request = try builder.build(endpoint)
        return try await session.send(request) { try JSONDecoder().decode(T.self, from: $0) }
    }
}
