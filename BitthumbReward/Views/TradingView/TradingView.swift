//
//  TradingView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct TradingView: View {
    @Environment(TradingViewModel.self) var trViewModel
    
    var coin: CoinRowViewModel
    
    var body: some View {
        @Bindable var vm = trViewModel
        
        VStack(spacing: 16) {
            Group {
                if let ovViewModel = trViewModel.overview {
                    TradingOverviewView(
                        coin.fullName,
                        ovViewModel: ovViewModel
                    )
                } else {
                    TradingOverviewView(
                        coin.fullName,
                        ovViewModel: .mock
                    )
                    .shimmering(active: true, redacted: .placeholder)
                }
            }
            .padding(.top)
            
            VStack {
                BuyAndSellButton(type: $vm.tradeType)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(trViewModel.purchasableCoin)
                        .font(.title2)
                        .fontWeight(.medium)
                    Text(coin.fullName)
                }
                
                TextField("거래 금액을 입력하세요.", text: $vm.tradeAmount)
                    .font(.title)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
            }
            .padding(.vertical, 32)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        Color.secondary.opacity(0.2),
                        style: .init(lineWidth: 1)
                    )
                    
            }
            .padding(10)
            
            Spacer(minLength: 10)
            
            Button {
                
            } label: {
                Text(vm.tradeType == .buy ? "매수하기" : "매도하기")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.background)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(vm.tradeType == .buy ?  .bithumbOrange : .blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
            }
            .padding(.bottom)
            .keyboardAdaptive(offset: 75)
        }
        .navigationTitle("코인 주문") // 버튼 타입에 따라 제목 달리하기
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Refresh", systemImage: "arrow.clockwise") {
                    // do something...
                }
            }
        }
        .background(.bithumbBackground)
        .task {
            do {
                try await trViewModel.fetchCurrentTradePrice(on: coin.ticker)
            } catch {
                // ...
            }
        }
    }
}

#Preview {
    NavigationStack {
        TradingView(
            coin: CoinRowViewModel(
                ticker: "BTC",
                fullName: "Bitcoin",
                tradePrice: 149_865_000,
                highPrice: 152_300_000,
                lowPrice: 147_200_000,
                changeRate: 0.0285555
            )
        )
        .environment(TradingViewModel())
    }
}
