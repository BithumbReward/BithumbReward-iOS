//
//  CoinListView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

struct CoinListView: View {
    @Environment(CoinListViewModel.self) var clViewModel
    
    var body: some View {
        @Bindable var vm = clViewModel
        NavigationStack {
            Group {
                if !clViewModel.listOfMarkets.isEmpty {
                    listOfCoinsView
                } else {
                    contentUnavailableView
                }
            }
            .background(.bithumbBackground)
            .navigationTitle("코인 목록")
        }
        .task {
            do {
                try await clViewModel.fetchAvailableMarkets()
            } catch {
                clViewModel.showWarningAlert = true
            }
        }
        .alert(
            "코인 목록 불러오기 실패",
            isPresented: $vm.showWarningAlert
        ) {
            Button("확인") { }
        } message: {
            Text("코인 목록을 불러올 수 없습니다. 잠시 후 다시 시도해주세요.")
        }
        
    }
    
    private var listOfCoinsView: some View {
        List(clViewModel.listOfMarkets) { coin in
            NavigationLink {
                TradingView(coin: coin)
            } label: {
                CoinRowView(viewModel: coin)
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
        CoinListView()
            .environment(CoinListViewModel())
    }
}

#Preview {
    NavigationStack {
        CoinListView()
            .environment(
                CoinListViewModel(
                    listOfMarkets: [
                        CoinRowViewModel(
                            ticker: "BTC",
                            fullName: "Bitcoin",
                            tradePrice: 149_865_000,
                            highPrice: 152_300_000,
                            lowPrice: 147_200_000,
                            changeRate: 0.0285555
                        ),
                        CoinRowViewModel(
                            ticker: "DOG",
                            fullName: "Dogecoin",
                            tradePrice: 67_445_344,
                            highPrice: 70_100_000,
                            lowPrice: 65_900_000,
                            changeRate: 0.123525
                        ),
                        CoinRowViewModel(
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
