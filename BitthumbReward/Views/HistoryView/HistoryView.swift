//
//  HistoryView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct HistoryView: View {
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
            EmptyView()
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
    HistoryView()
}
