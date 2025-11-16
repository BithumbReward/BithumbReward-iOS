//
//  BitthumbRewardApp.swift
//  BitthumbReward
//
//  Created by kangho on 11/12/25.
//

import SwiftUI

@main
struct BitthumbRewardApp: App {
    @State private var clViewModel = CoinListViewModel()
    @State private var trViewModel = TradingViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(clViewModel)
                .environment(trViewModel)
        }
    }
}
