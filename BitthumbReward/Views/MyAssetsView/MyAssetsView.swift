//
//  MyAssetsView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct MyAssetsView: View {
    @Environment(MyAssetsViewModel.self) var viewModel
    
    var body: some View {
        Group {
            ScrollView {
                balanceView
                
                if viewModel.assetRows.isEmpty {
                    ContentUnavailableView(
                        "자산 목록이 없습니다.",
                        systemImage: "bitcoinsign.circle.fill",
                        description: Text("거래를 시작해보세요.")
                    )
                    .padding(.vertical)
                } else {
                    assetList
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetch()
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .background(.bithumbBackground)
        .task {
            await viewModel.fetch()
        }
    }
}

extension MyAssetsView {
    
    private var assetList: some View {
        VStack(spacing: 0) {
            Section {
                ForEach(viewModel.assetRows) { vm in
                    AccountRow(viewModel: vm)
                }
            } header: {
                HStack {
                    Text("보유 종목")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding(.vertical, 16)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var balanceView: some View {
        VStack(spacing: 8) {
            Text("Total Balance")
                .font(.title3)
            HStack(alignment: .lastTextBaseline) {
                Text(viewModel.balance, format: .currency(code: "KRW"))
                    .font(.largeTitle)
                    .bold()
                
                Text("KOR")
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .containerRelativeFrame(.vertical) { value, _  in
            value / 3
        }
        .background {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.btOrange)
        }
    }
}

#Preview {
    MyAssetsView()
}

