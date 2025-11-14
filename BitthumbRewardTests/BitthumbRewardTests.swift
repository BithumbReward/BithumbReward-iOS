//
//  BitthumbRewardTests.swift
//  BitthumbRewardTests
//
//  Created by kangho on 11/13/25.
//

import Testing
@testable import BitthumbReward

struct BitthumbRewardTests {

    @Test func example() async throws {
        let client = BithumbClient(session: .shared)
        
        let markets = try await client.markets()
        
        #expect(markets.count > 0)
    }
}
