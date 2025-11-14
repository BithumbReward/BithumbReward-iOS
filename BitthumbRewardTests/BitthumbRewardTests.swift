//
//  BitthumbRewardTests.swift
//  BitthumbRewardTests
//
//  Created by kangho on 11/13/25.
//

import Testing
@testable import BitthumbReward

struct BitthumbRewardTests {

    @Test func market() async throws {
        let client = BithumbClient(session: .shared)
        
        let markets = try await client.markets()
        
        #expect(markets.count > 0)
    }
    
    @Test func account() async throws {
        let client = BithumbClient(session: .shared)
        
        let account = try await client.account()
        
        #expect(account.isEmpty == true)
    }
}
