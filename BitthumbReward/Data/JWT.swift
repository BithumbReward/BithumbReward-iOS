//
//  JWT.swift
//  BitthumbReward
//
//  Created by kangho on 11/12/25.
//

import Foundation
import CryptoKit

enum JWT {
    static func generateJWT(accessKey: String, secretKey: String, query: [String: Any]) throws -> String {
        let queryString = query.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        
        let queryData = Data(queryString.utf8)
        let queryHash = SHA512.hash(data: queryData)
        let queryHashHex = queryHash.map { String(format: "%02x", $0) }.joined()
        
        let payload = Payload(
            accessKey: accessKey,
            nonce: UUID().uuidString,
            timestamp: Int(Date().timeIntervalSince1970 * 1000),
            queryHash: queryHashHex,
            queryHashAlg: "SHA512"
        )
        
        let header = Header(typ: "JWT", alg: "HS256")
        let headerData = try JSONEncoder().encode(header).base64URLEncode()
        let payloadData = try JSONEncoder().encode(payload).base64URLEncode()
        
        let message = "\(headerData).\(payloadData)"
        
        // HMAC Sign
        let key = SymmetricKey(data: Data(secretKey.utf8))
        let signature = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: key)
        let signatureBase64 = Data(signature).base64URLEncode()
        
        return "\(message).\(signatureBase64)"
    }
}

extension JWT {
    struct Header: Codable {
        let typ: String
        let alg: String
    }
    
    struct Payload: Codable {
        let accessKey: String
        let nonce: String
        let timestamp: Int
        let queryHash: String
        let queryHashAlg: String
        
        private enum CodingKeys: String, CodingKey {
            case accessKey = "access_key"
            case nonce
            case timestamp
            case queryHash = "query_hash"
            case queryHashAlg = "query_hash_alg"
        }
    }
}


