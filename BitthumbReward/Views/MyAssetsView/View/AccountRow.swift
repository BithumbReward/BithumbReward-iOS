//
//  AccountRow.swift
//  BitthumbReward
//
//  Created by kangho on 11/14/25.
//

import SwiftUI

struct AccountRow: View {
    let viewModel: AssetRowViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.currency)
                    .fontWeight(.medium)
                
                Text(viewModel.balance, format: .percent.precision(.fractionLength(10)))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(viewModel.balanceKRW, format: .currency(code: "KRW"))
                    .bold()
                
                Text(viewModel.changeValue)
                    .fontWeight(.medium)
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 8)
    }
}
