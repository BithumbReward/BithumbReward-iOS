//
//  CoinRowView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

struct CoinRowView: View {
    let viewModel: CoinRowViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.ticker)
                Text(viewModel.fullName)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(viewModel.tradePrice)")
                Text(viewModel.formattedChangeRate)
                    .foregroundStyle(viewModel.changeRate > 0.0 ? Color.red : Color.blue)
            }
            .fontWeight(.medium)
        }
    }
}

#Preview {
    CoinRowView(
        viewModel: .init(
            ticker: "BTC-KRW",
            fullName: "Bitcoin",
            tradePrice: 149864000,
            changeRate: 0.0233295
        )
    )
}
