//
//  MyAssetsView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct MyAssetsView: View {
    @State var accounts: Accounts = .previews

    var balance: Double {
        Double(accounts.first(where: { $0.currency == "KRW" })?.balance ?? "0") ?? 0
    }
    var client = BithumbClient(session: .shared)
    
    var body: some View {
        ScrollView {
            BalanceView(balance: balance)
                
            VStack(spacing: 0) {
                Section {
                    ForEach(accounts) { account in
                        AccountRow(account: account)
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
        .ignoresSafeArea(edges: .top)
        .background(Color.bithumbBackground)
        .task {
            do {
                accounts = try await client.account()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    MyAssetsView()
}

struct BalanceView: View {
    let balance: Double
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Total Balance")
                .font(.title3)
            HStack(alignment: .lastTextBaseline) {
                Text(balance, format: .currency(code: "KRW"))
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
