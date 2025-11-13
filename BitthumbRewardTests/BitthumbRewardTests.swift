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
        let result = JWT.generateJWT(accessKey: "1234", secretKey: "1234", query: ["number": "123"])
        #expect(<#T##condition: Bool##Bool#>)
    }

}
