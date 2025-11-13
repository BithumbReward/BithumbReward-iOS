//
//  Data+Util.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

extension Data {
    func base64URLEncode() -> String {
        return base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
