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
        Group {
            if !clViewModel.listOfCoins.isEmpty {
                listOfCoinsView
            } else {
                contentUnavailableView
            }
        }
        .navigationTitle("코인 목록")
        .navigationBarTitleDisplayMode(.inline)
        .background(.bithumbBackground)
    }
    
    private var listOfCoinsView: some View {
        List(clViewModel.listOfCoins) { coin in
            NavigationLink(value: coin) { [vm = coin] in
                CoinRowView(viewModel: vm)
            }
        }
        .navigationDestination(for: CoinRowViewModel.self) { coin in
            TradingView(coin: coin)
        }
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
                    listOfCoins: [
                        CoinRowViewModel(
                            ticker: "BTC",
                            fullName: "Bitcoin",
                            tradePrice: 149865000,
                            changeRate: 0.0285555
                        ),
                        CoinRowViewModel(
                            ticker: "DOG",
                            fullName: "Dogecoin",
                            tradePrice: 67445344,
                            changeRate: 0.123525
                        ),
                        CoinRowViewModel(
                            ticker: "ETH",
                            fullName: "Ethereum",
                            tradePrice: 53424444,
                            changeRate: 0.412923
                        )
                    ]
                )
            )
    }
}
