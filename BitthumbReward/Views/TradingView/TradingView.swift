//
//  TradingView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct TradingView: View {
    var coin: CoinRowViewModel
    
    var body: some View {
        Text("TradingView")
    }
}

#Preview {
    TradingView(
        coin: .init(
            ticker: "BTC-KRW",
            fullName: "Bitcoin",
            tradePrice: 149864000,
            changeRate: 0.0233295
        )
    )
}
