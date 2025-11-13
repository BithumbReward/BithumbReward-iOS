//
//  Shimmer.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct Shimmer: ViewModifier {
    
    private let bandSize: CGFloat = 0.7
    private let min, max: CGFloat
    @State private var isInitialState = true
    
    init() {
        self.min = 0.0 - bandSize
        self.max = 1.0 + bandSize
    }
    
    private var animation: Animation = Animation.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false)
    
    private var startPoint: UnitPoint {
        isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
    }
    
    private var endPooint: UnitPoint {
        isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
    }
    
    private var gradient: [Color] = {
        [
            .black.opacity(0.3),
            .black,
            .black.opacity(0.3)
        ]
    }()
    
    func body(content: Content) -> some View {
        applyGradient(content: content)
            .animation(animation, value: isInitialState)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.isInitialState = false
                }
            }
    }
    
    private func applyGradient(content: Content) -> some View {
        let gradient = LinearGradient(
            colors: gradient,
            startPoint: startPoint,
            endPoint: endPooint
        )
        return content.mask(gradient)
    }
}

extension View {
    
    /// 뷰에 반짝이는 로딩(shimmering) 효과를 적용합니다.
    ///
    /// - Parameters:
    ///   - active: `true`일 때 shimmering 효과를 활성화합니다. 기본값은 `true`입니다.
    ///   - reason: `redacted` 효과에 사용할 `RedactionReasons` 값입니다. 기본값은 `.invalidated`입니다.
    ///
    /// - Returns: shimmering 및 redacted 효과가 적용된 뷰를 반환합니다.
    ///
    /// 이 메서드는 뷰의 로딩 상태를 표현할 때 사용하며,
    /// `active`가 `false`인 경우 원본 뷰를 그대로 표시합니다.
    @ViewBuilder func shimmering(
        active: Bool,
        redacted reason: RedactionReasons = .invalidated
    ) -> some View {
        if active {
            modifier(Shimmer())
                .redacted(reason: reason)
        } else {
            self
        }
    }
}



#Preview("Shimmering-Effect") {
    @Previewable @State var active = true
    Text("BitthumbReward-iOS")
        .shimmering(active: active)
    
    Text("BitthumbReward-iOS-Placeholder")
        .shimmering(active: active, redacted: .placeholder)
}
