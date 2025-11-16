//
//  KeyboardApdaptive+Modifier.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/16/25.
//

import Combine
import SwiftUI

struct KeyboardAdaptive: ViewModifier {
    private var offset: CGFloat?
    @State private var keyboardHeight: CGFloat = 0
    
    init(offset: CGFloat? = nil) {
        self.offset = offset
    }
    
    private var keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { notification in
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        }
        .map { rect in
            rect.height
        }
    
    private var keyboardDidHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardDidHideNotification)
        .map { _ in CGFloat(0.0) }
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardWillShow) { height in
                withAnimation {
                    keyboardHeight = offset ?? height
                }
            }
            .onReceive(keyboardDidHide) { height in
                withAnimation {
                    keyboardHeight = 0.0
                }
            }
    }
}

extension View {
    
    func keyboardAdaptive(offset: CGFloat? = nil) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(offset: offset))
    }
}
