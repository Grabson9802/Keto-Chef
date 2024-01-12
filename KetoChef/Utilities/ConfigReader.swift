//
//  ConfigReader.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 10/01/2024.
//

import Foundation

class ConfigReader {
    static func readApiKey() -> String? {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let configDict = NSDictionary(contentsOfFile: path),
           let apiKey = configDict["ApiKey"] as? String {
            return apiKey
        }
        return nil
    }
}
