//
//   BuyAndSellButton.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

struct BuyAndSellButton: View {
    @Binding var type: BuyAndSellButton.`Type`
    
    var body: some View {
        Button {
            type.toggle()
        } label: {
            Text(type.title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .label))
                .frame(width: 60)
                .padding(.vertical, 6)
                .background {
                    Capsule()
                        .stroke(
                            Color(uiColor: .label),
                            style: StrokeStyle(lineWidth: 1)
                        )
                }
            
        }
    }
}

extension BuyAndSellButton {
    
    enum `Type` {
        case buy, sell
        
        var title: String {
            switch self {
            case .buy: return "Buy"
            case .sell: return "Sell"
            }
        }
        
        mutating func toggle() {
            self = (self == .buy ? .sell : .buy)
        }
    }
}



#Preview {
    @Previewable @State var type: BuyAndSellButton.`Type` = .buy
    BuyAndSellButton(type: $type)
}
