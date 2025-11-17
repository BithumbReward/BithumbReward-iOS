//
//  TradeHistoryView.swift
//  BitthumbReward
//
//  Created by kangho on 11/16/25.
//

import SwiftUI

struct TradeHistoryView: View {
    private let client = BithumbClient(session: .shared)
    @State private var orders = [Order]()
    
    typealias Coin = String
    let coin: Coin
    
    var body: some View {
        VStack {
            Button("조회") {
                Task {
                    do {
                        orders = try await client.fetchOrders(
                            .init(
                                market: "KRW-BTC",
                                uuids: [],
                                state: "done",
                                states: []
                            )
                        )
                        print(orders)
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("주문") {
                Task {
                    do {
                        let order = try await client.order(
                            .init(
                                market: "KRW-BTC",
                                side: "bid",
                                volume: 0,
                                price: 5000,
                                orderType: "price"
                            )
                        )
                        orders.insert(order, at: 0)
                    } catch {
                        print(error)
                    }
                }
            }
            
            if orders.isEmpty {
                ContentUnavailableView(
                    "주문 내역이 없습니다",
                    systemImage: "receipt.fill",
                    description: Text("거래 필요")
                )
            } else {
                List(orders) { order in
                    HStack {
                        Text(order.uuid)
                        Text(order.createdAt, format: .dateTime)
                    }
                    OrderView(order: order)
                        .frame(height: .infinity)
                }
            }
        }
    }
}

struct OrderView: View {
    let order: Order
    
    var dict: [(String, Any)] {
        (try? order.toDictionary()
            .map {
            ($0.key, $0.value)
        }) ?? []
    }
    
    var body: some View {
        List(dict, id: \.0) { key, value in
            HStack {
                Text(key)
                
                Text(value as? String ?? "\(value)")
            }
        }
    }
}

#Preview {
    OrderView(
        order: .preview
    )
}
