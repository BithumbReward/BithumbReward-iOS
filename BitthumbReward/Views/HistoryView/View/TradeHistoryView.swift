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
            if orders.isEmpty {
                ContentUnavailableView(
                    "주문 내역이 없습니다",
                    systemImage: "receipt.fill",
                    description: Text("거래 필요")
                )
            } else {
                List(orders) { order in
                    OrderView(order: order)
                }
            }
        }
        .navigationTitle(coin + " 주문 내역")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                orders = try await client.fetchOrders(
                    .init(
                        market: coin,
                        state: "done"
                    )
                )
                print(orders)
            } catch {
                print(error)
            }
        }
    }
}

struct OrderView: View {
    let order: Order
    
    var orderTitle: String {
        order.side.title + " " + order.ordType.title
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(orderTitle)
                            .fontWeight(.medium)
                            .foregroundStyle(order.ordType == .price ? .red : .blue)
                        Text(order.market.replacingOccurrences(of: "-", with: " / "))
                            .font(.footnote)
                    }
                    Text(order.createdAt, format: .dateTime)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                }
                Spacer()
                
                Text(order.state.title)
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                
            }.padding(.vertical, 8)
            
            HStack {
                Text("주문금액")
                Spacer()
                Text(order.price + "원")
            }
            
            HStack {
                Text("주문가격")
                Spacer()
                Text("-")
            }
            
            HStack {
                Text("주문수량")
                Spacer()
                Text("-")
            }
            
            HStack {
                Text("체결수량")
                Spacer()
                Text(order.executedVolume)
                Text(order.market.components(separatedBy: "-")[1])
            }
        }
    }
}

#Preview {
    OrderView(
        order: .preview
    )
    .padding()
}
