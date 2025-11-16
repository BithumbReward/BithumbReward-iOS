//
//  AccountRow.swift
//  BitthumbReward
//
//  Created by kangho on 11/16/25.
//
//
//  AccountRow.swift
//  BitthumbReward
//
//  Created by kangho on 11/14/25.
//

import SwiftUI

struct AccountRow: View {
    let viewModel: AssetRowViewModel
    
    var changeColor: Color {
        if viewModel.changeRate == 0 {
            return .secondary
        }
        
        return viewModel.changeRate > 0 ? .blue : .red
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .fontWeight(.medium)
                
                Text(viewModel.balance)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(viewModel.balanceKRW, format: .currency(code: "KRW"))
                    .bold()
                
                Text(viewModel.changeValue)
                    .fontWeight(.medium)
                    .foregroundStyle(changeColor)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    AccountRow(viewModel: .preview)
        .padding()
}
