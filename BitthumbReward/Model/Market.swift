//
//  Market.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

// MARK: - Market
struct Market: Codable {
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

typealias Markets = [Market]
