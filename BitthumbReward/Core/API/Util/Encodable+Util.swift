//
//  Encodable+Util.swift
//  BitthumbReward
//
//  Created by kangho on 11/12/25.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        guard let dictionary = json as? [String: Any] else {
            throw NSError(domain: "Invalid JSON format", code: 0, userInfo: nil)
        }
        return dictionary
    }
}
