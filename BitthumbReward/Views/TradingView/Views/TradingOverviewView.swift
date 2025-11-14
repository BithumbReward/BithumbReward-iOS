//
//  TradingOverviewView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

struct TradingOverviewView: View {
    var ovViewModel: TradingOverviewViewModel
    
    let padding: CGFloat = 12
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(ovViewModel.fullName)
                    .fontWeight(.bold)
                Text("( \(ovViewModel.ticker) )")
                    .foregroundStyle(.secondary)
            }
            
            Text("\(ovViewModel.tradePrice)")
                .font(.system(size: 48))
                .fontWeight(.medium)
            
            HStack {
                box(
                    "\(ovViewModel.highPrice.formatted())",
                    text: "52주 최고가"
                )
                box(
                    "\(ovViewModel.lowPrice.formatted())",
                    text: "52주 최저가"
                )
                box(
                    ovViewModel.formattedChangeRate,
                    text: "변동률",
                    highlighting: true
                )
            }
        }
    }
    
    private func box(
        _ price: String,
        text: String,
        highlighting: Bool = false
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(price)
                .if(highlighting) { content in
                    content
                        .foregroundStyle(ovViewModel.changeRate > 0.0 ? Color.red : Color.blue)
                }
                .fontWeight(.medium)
                .lineLimit(1)
            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .containerRelativeFrame(.horizontal) { width, _ in
            width / 3 - (padding * 3)
        }
        .padding(padding)
        .background(
            Color.secondary.opacity(0.2),
            in: RoundedRectangle(cornerRadius: 20)
        )
    }
}

#Preview {
    TradingOverviewView(
        ovViewModel: .init(
            ticker: "BTC-KRW",
            fullName: "Bitcoin",
            tradePrice: 149322000,
            highPrice: 198323000,
            lowPrice: 73492390,
            changeRate: 0.0012345
        )
    )
}
