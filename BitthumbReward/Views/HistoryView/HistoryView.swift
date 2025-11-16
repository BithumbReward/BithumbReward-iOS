//
//  HistoryView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct HistoryView<Content: View>: View {
    @Environment(CoinListViewModel.self) var clViewModel
    
    var content: (String) -> Content
    
    init(@ViewBuilder content: @escaping (String) -> Content) {
        self.content = content
    }
    
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
            .navigationTitle("주문 거래서 목록")
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
                content("BTC")
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
    HistoryView { coin in
        TradeHistoryView(coin: coin)
    }
}
