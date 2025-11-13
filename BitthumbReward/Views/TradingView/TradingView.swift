//
//  TradingView.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct TradingView: View {
    @State private var active = true
    
    var body: some View {
        NavigationStack {
            Text("TradingView")
                .offset(y: 100)
        }
        .loadingIndicator(active: active)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                active = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    active = true
                }
            }
        }
    }
}

#Preview {
    TradingView()
}
