//
//  LoadingPulseOutline.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct LoadingPulseOutline: View {
    @State private var isAnimation = false
    
    let duration: Double = 1.5
    let maxCounter: Int = 3
    
    var body: some View {
        ZStack {
            ForEach(0..<maxCounter, id: \.self) { index in
                Circle()
                    .stroke(
                        Color.orange,
                        lineWidth: isAnimation ? 0.0 : 15.0
                    )
                    .scaleEffect(isAnimation ? 1.0 : 0.0)
                    .animation(
                        Animation.easeOut(duration: duration)
                            .repeatForever(autoreverses: false)
                            .delay(Double(index) * duration / Double(maxCounter)),
                        value: isAnimation
                    )
            }
        }
        .onAppear {
            isAnimation.toggle()
        }
    }
}


#Preview("LoadingPulseOutline", traits: .fixedLayout(width: 100, height: 100)) {
    LoadingPulseOutline()
}
