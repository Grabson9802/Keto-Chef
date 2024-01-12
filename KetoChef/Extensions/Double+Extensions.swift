//
//  Double.swift
//  KetoChef
//
//  Created by Krystian Grabowy on 11/01/2024.
//

import Foundation

extension Double {
    func roundedWithoutZeros() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.numberStyle = .decimal

        if let formattedString = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "\(self)"
        }
    }
}
