//
//  If+Modifier.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

extension View {
    
    ///
    @ViewBuilder func `if`<Content>(
        _ predicate: @autoclosure () -> Bool,
        content: (Self) -> Content
    ) -> some View where Content: View {
        if predicate() {
            content(self)
        } else {
            self
        }
    }
}
