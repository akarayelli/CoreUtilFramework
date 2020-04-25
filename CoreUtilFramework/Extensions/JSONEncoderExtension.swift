//  JSONEncoderExtension.swift
//  CoreUtilFramework 
//
//  User: Alican.Karayelli
//  Date: 26.04.2020
//  Time: 01:24

import Foundation

@available(iOS 10.0, *)
public extension JSONEncoder.DateEncodingStrategy {
    @available(iOS 11.0, *)
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}

