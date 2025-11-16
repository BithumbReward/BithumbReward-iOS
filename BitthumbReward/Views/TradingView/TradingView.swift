//
//  TradingView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct TradingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = TradingViewModel()
    
    var market: MarketRowViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            tradingOverviewView
            
            tradeAmountTextField
            
            Spacer(minLength: 10)
            
            coinBuyAndSellButton
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Refresh", systemImage: "arrow.clockwise") {
                    fetchCurrentTradePrice()
                }
            }
        }
        .alert(
            "코인 정보 불러오기 실패",
            isPresented: $viewModel.showWarningAlert
        ) {
            Button("확인") {
                dismiss()
            }
        } message: {
            Text("코인 정보를 불러올 수 없습니다. 잠시 후 다시 시도해주세요.")
        }
        .task {
            fetchCurrentTradePrice()
        }
        .navigationTitle("코인 주문")
        .navigationBarTitleDisplayMode(.inline)
        .background(.bithumbBackground)
    }
    
    private var tradingOverviewView: some View {
        Group {
            if let overview = viewModel.overview {
                TradingOverviewView(
                    market.fullName,
                    overview: overview
                )
            } else {
                TradingOverviewView(
                    market.fullName,
                    overview: .mock
                )
                .shimmering(active: true, redacted: .placeholder)
            }
        }
        .padding(.top)
    }
    
    private var tradeAmountTextField: some View {
        VStack {
            BuyAndSellButton(type: $viewModel.tradeType)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(viewModel.purchasableCoin)
                    .font(.title2)
                    .fontWeight(.medium)
                Text(market.fullName)
            }
            
            TextField("거래 금액을 입력하세요.", text: $viewModel.tradeAmount)
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
    }
    
    private var coinBuyAndSellButton: some View {
        Button {
//            viewModel.tradeMarket(
//                market.ticker,
//                side: <#T##String#>,
//                volume: <#T##Double#>,
//                price: <#T##Double#>
//            )
        } label: {
            Text(viewModel.tradeType == .buy ? "매수하기" : "매도하기")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.background)
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.tradeType == .buy ?  .bithumbOrange : .blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
        }
        .padding(.bottom)
        .keyboardAdaptive(offset: 75)
    }
    
    private func fetchCurrentTradePrice() {
        Task {
            do {
                try await viewModel.fetchCurrentTradePrice(on: market.ticker)
            } catch {
                viewModel.showWarningAlert = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        TradingView(
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
}
