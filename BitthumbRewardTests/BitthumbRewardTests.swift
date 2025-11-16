//
//  BitthumbRewardTests.swift
//  BitthumbRewardTests
//
//  Created by kangho on 11/13/25.
//

import Testing
import Foundation
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
    
    @Test func encode_datetime() async throws {
        
        let json = Data(
        """
        {
           "created_at": "2025-11-16T18:11:27+09:00"
        }
        """.utf8)
        
        do {
            var decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
            let sample = try decoder.decode(Sample.self, from: json)
            #expect(true)
        } catch {
            print(error)
            assertionFailure(error.localizedDescription)
        }
        
        
    }
    
    struct Sample: Codable {
        let created_at: Date
    }
}
