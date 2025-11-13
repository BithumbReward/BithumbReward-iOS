//
//  Environment.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

enum Environment {
    static var baseURL: URL {
        guard let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let url = URL(string: baseURLString)
        else {
            fatalError("BASE URL Not Found!")
        }
        return url
    }
    
    static var accessKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_ACCESS_KEY") as? String
        else {
            fatalError(#function + ": API Access Key Not Found!")
        }
        return key
    }
    
    static var secretKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_SECRET_KEY") as? String
        else {
            fatalError(#function + ": API SCRET Key Not Found!")
        }
        return key
    }
}
