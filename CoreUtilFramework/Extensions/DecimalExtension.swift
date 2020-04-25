//  DecimalExtension.swift
//  CoreUtilFramework 
//
//  User: Alican.Karayelli
//  Date: 26.04.2020
//  Time: 01:12

import Foundation

public extension Decimal {
    
    var formattedAmount: String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr")
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.string(from: self as NSDecimalNumber)
    }
}

