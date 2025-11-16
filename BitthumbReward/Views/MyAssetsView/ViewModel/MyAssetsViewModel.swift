//
//  MyAssetsViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

@Observable
final class MyAssetsViewModel {
    private let client: BithumbClient
    var assetRows: [AssetRowViewModel] = []
    
    init(client: BithumbClient = BithumbClient(session: .shared)) {
        self.client = client
    }
    
    var balance: Double = 0
    
    func fetch() async {
        do {
            let accounts = try await client.account()
            balance = Double(accounts.first(where: { $0.currency == "KRW" })?.balance ?? "0") ?? 0
            assetRows = accounts
                .filter { $0.currency != "KRW" }
                .map { account in
                    AssetRowViewModel(account: account)
                }
        } catch {
            print(error)
        }
    }
}
