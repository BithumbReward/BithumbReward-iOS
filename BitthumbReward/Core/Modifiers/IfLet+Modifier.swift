//
//  IfLet+Modifier.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

extension View {
    
    ///
    @ViewBuilder func `ifLet`<Optional, IfContent, ElseContent>(
        _ optional: Optional?,
        if: (Self, Optional) -> IfContent,
        else: (Self) -> ElseContent
    ) -> some View where IfContent: View, ElseContent: View {
        if let optional = optional {
            `if`(self, optional)
        } else {
            `else`(self)
        }
    }
}

