//
//  MarketListView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

struct MarketListView: View {
    @State private var viewModel = MarketListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if !viewModel.listOfMarkets.isEmpty {
                    contentListView
                } else {
                    contentUnavailableView
                }
            }
            .background(.bithumbBackground)
            .navigationTitle("코인 목록")
        }
        .task {
            do {
                try await viewModel.fetchAvailableMarkets()
            } catch {
                viewModel.showWarningAlert = true
            }
        }
        .alert(
            "코인 목록 불러오기 실패",
            isPresented: $viewModel.showWarningAlert
        ) {
            Button("확인") { }
        } message: {
            Text("코인 목록을 불러올 수 없습니다. 잠시 후 다시 시도해주세요.")
        }
        
    }
    
    private var contentListView: some View {
        List(viewModel.listOfMarkets) { market in
            NavigationLink {
                TradingView(market: market)
            } label: {
                MarketRowView(market: market)
            }
        }
        .listRowBackground(Color.white)
        .scrollContentBackground(.hidden)
    }
    
    private var contentUnavailableView: some View {
        ContentUnavailableView(
            "코인 목록을 불러올 수 없어요.",
            systemImage: "network.slash",
            description: Text("잠시 후 다시 시도해주세요.")
        )
    }
}

#Preview {
    NavigationStack {
        MarketListView()
            .environment(MarketListViewModel())
    }
}

#Preview {
    NavigationStack {
        MarketListView()
            .environment(
                MarketListViewModel(
                    listOfMarkets: [
                        MarketRowViewModel(
                            ticker: "BTC",
                            fullName: "Bitcoin",
                            tradePrice: 149_865_000,
                            highPrice: 152_300_000,
                            lowPrice: 147_200_000,
                            changeRate: 0.0285555
                        ),
                        MarketRowViewModel(
                            ticker: "DOG",
                            fullName: "Dogecoin",
                            tradePrice: 67_445_344,
                            highPrice: 70_100_000,
                            lowPrice: 65_900_000,
                            changeRate: 0.123525
                        ),
                        MarketRowViewModel(
                            ticker: "ETH",
                            fullName: "Ethereum",
                            tradePrice: 53_424_444,
                            highPrice: 55_200_000,
                            lowPrice: 51_800_000,
                            changeRate: 0.412923
                        )
                    ]
                )
            )
    }
}
