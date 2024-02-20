//
//  Extensions.swift
//  CWK2Template
//
//  Created by Vat on 2024-01-02.
//

import Foundation
import SwiftUI

// Extension for rounded Double to 1 decimals
extension Double {
    //round the Double to one decimal place and convert it to a String
    func roundDouble() -> String {
        return String(format: "%.1f", self)
    }
}

extension Int{
    // round the Int to the nearest integer and convert it to a String
    func roundToIntString() -> String {
            return String(Int(self))
        }
}
