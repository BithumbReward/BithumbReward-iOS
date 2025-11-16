//
//  HistoryView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct HistoryView<Content: View>: View {
    @State private var viewModel = MarketListViewModel()
    
    var content: (String) -> Content
    
    init(@ViewBuilder content: @escaping (String) -> Content) {
        self.content = content
    }
    
    var body: some View {
        @Bindable var vm = viewModel
        NavigationStack {
            Group {
                if !viewModel.listOfMarkets.isEmpty {
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
                try await viewModel.fetchAvailableMarkets()
            } catch {
                viewModel.showWarningAlert = true
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
        List(viewModel.listOfMarkets) { market in
            NavigationLink {
                content("KRW-BTC")
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
    HistoryView { coin in
        TradeHistoryView(coin: coin)
    }
}
