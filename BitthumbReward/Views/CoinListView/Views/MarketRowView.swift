//
//  MarketRowView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

struct MarketRowView: View {
    let market: MarketRowViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(market.ticker)
                Text(market.fullName)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(market.formattedTradePrice)
                Text(market.formattedChangeRate)
                    .foregroundStyle(market.changeRate > 0.0 ? Color.red : Color.blue)
            }
            .fontWeight(.medium)
        }
    }
}

#Preview {
    MarketRowView(
        market: MarketRowViewModel(
            ticker: "BTC",
            fullName: "Bitcoin",
            tradePrice: 149_865_000,
            highPrice: 152_300_000,
            lowPrice: 147_200_000,
            changeRate: 0.0285555
        )
    )
}
