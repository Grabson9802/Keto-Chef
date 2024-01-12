//
//  String.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 11/01/2024.
//

import Foundation

extension String {
    func removeHTMLTagsAndBraces() -> String {
        var cleanedString = self
        
        cleanedString = cleanedString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cleanedString = cleanedString.replacingOccurrences(of: "\\{[^\\}]+\\}", with: "", options: .regularExpression, range: nil)
        
        return cleanedString
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
}
