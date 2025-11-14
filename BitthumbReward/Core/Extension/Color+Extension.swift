//
//  Color+Extension.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    
    ///
    static var bithumbBackground: Color {
        Color(uiColor: UIColor(resource: .btBackground))
    }
    
    ///
    static var bithumbOrange: Color {
        Color(uiColor: UIColor(resource: .btOrange))
    }
}
