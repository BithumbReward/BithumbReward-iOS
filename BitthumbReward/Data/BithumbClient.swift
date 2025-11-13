//
//  BithumbClient.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

public class BithumbClient {
    
}

// MARK: Public API

extension BithumbClient {
    
    /// market에서 거래되는 코인 목록 조회
    func markets() async throws -> [Market] {
        return []
    }
    
    /// 입력한 마켓의 시세를 조회
    func ticker(_ markets: [String]) async throws -> [Ticker] {
        return []
    }
}

// MARK: Private API

extension BithumbClient {
    
    /// 보유한 화폐의 매수평균가, 보유 금액 등 조회
    func account() async throws -> [Account] {
        return []
    }
    
    /// 코인 주문 리스트 조회
    func fetchOrders(_ fetchOrder: OrderFetchRequest) async throws -> [Order] {
        return []
    }
    
    /// 코인 주문
    @discardableResult
    func order(_ param: OrderRequest) async throws -> Order {
        Order(
          uuid: "C0101000000001799653",
          side: "bid",
          ordType: "limit",
          price: "84000000",
          state: "wait",
          market: "KRW-BTC",
          createdAt: Date(),
          volume: "0.0001",
          remainingVolume: "0.0001",
          reservedFee: "21",
          remainingFee: "21",
          paidFee: "0",
          locked: "8422",
          executedVolume: "0",
          tradesCount: 0
        )
    }
}
