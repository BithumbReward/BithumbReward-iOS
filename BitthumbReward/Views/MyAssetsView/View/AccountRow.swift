//
//  AccountRow.swift
//  BitthumbReward
//
//  Created by kangho on 11/14/25.
//

import SwiftUI

struct AccountRow: View {
    let account: Account
    let currentPrice: Double = 1000
    
    /// 원화 환산 금액 - balance - current price
    var balanceKRW: Double {
//        currentPrice * (Double(account.balance) ?? 0)
        57698
    }
    
    /// 등락폭 - current ticker / ave buy Price
    var changeRate: Double {
        return 0
    }
    
    /// 등락금액 - 등락폭 * balance
    var changePrice: Double {
        (Double(account.balance) ?? 0) * changeRate
    }
    
    var changeValue: String {
        "+11,436(24.7%)"
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(account.currency)
                    .fontWeight(.medium)
                
                Text(account.balance)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(balanceKRW, format: .currency(code: "KRW"))
                    .bold()
                
                Text(changeValue)
                    .fontWeight(.medium)
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 8)
    }
}
