//
//  LoadingIndicator.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

struct LoadingIndicator: View {
    
    let size: CGFloat = 120
    
    var body: some View {
        LoadingCircleRunner()
            .padding(30)
            .frame(width: size, height: size)
            .background {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.secondary.opacity(0.2))
            }
            .transition(.opacity)
    }
}

extension View {
    
    /// 뷰 위에 로딩 인디케이터를 표시합니다.
    ///
    /// - Parameter active: `true`일 때 로딩 인디케이터를 표시하며,
    ///   `false`일 경우 원본 뷰를 그대로 보여줍니다.
    ///
    /// - Returns: 로딩 인디케이터가 적용된 뷰를 반환합니다.
    @ViewBuilder func loadingIndicator(active: Bool) -> some View {
        self
            .overlay {
                if active {
                    LoadingIndicator()
                }
            }
            .animation(.easeInOut(duration: 0.5), value: active)
    }
}



#Preview {
    @Previewable @State var active = true
    NavigationStack {
        List(0..<10, id: \.self) { index in
            Text("\(index)")
        }
    }
    .loadingIndicator(active: active)
}
