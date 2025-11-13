//
//  LoadingCircleRunner.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct LoadingCircleRunner: View {
    @State private var isAnimating = false
    let duration: Double = 2.0
    
    let height: CGFloat = 50
    
    var body: some View {
        Circle()
            .trim(from: isAnimating ? 0.9 : 0.8, to: 1.0)
            .stroke(
                Color.orange,
                style: StrokeStyle(lineWidth: isAnimating ? 5 : 2.5 , lineCap: .round, lineJoin: .round)
            )
            .animation(
                Animation.easeInOut(duration: duration / 2).repeatForever(),
                value: isAnimating
            )
            .rotationEffect(
                Angle(degrees: isAnimating ? 360 : 0)
            )
            .animation(
                Animation.linear(duration: duration).repeatForever(autoreverses: false),
                value: isAnimating
            )
            .rotationEffect(
                Angle(degrees: 360 * 0.5)
            )
            .onAppear {
                isAnimating = true
            }
    }
}

#Preview {
    LoadingCircleRunner()
}
