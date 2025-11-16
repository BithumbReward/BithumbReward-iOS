//
//  ContentView.swift
//  BitthumbReward
//
//  Created by kangho on 11/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("내 자산", systemImage: "wallet.bifold.fill") {
                NavigationStack {
                    MyAssetsView()
                }
            }
            
            Tab("주문", systemImage: "chart.line.uptrend.xyaxis") {
                MarketListView()
            }
            
            Tab("기록", systemImage: "clock.fill") {
                NavigationStack {
                    HistoryView { coin in
                        TradeHistoryView(coin: coin)
                    }
                }
            }
        }
        .tint(.orange)
    }
}

#Preview {
    ContentView()
}
