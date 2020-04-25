//  JSONDecoderExtension.swift
//  CoreUtilFramework 
//
//  User: Alican.Karayelli
//  Date: 26.04.2020
//  Time: 01:23

import Foundation

@available(iOS 10.0, *)
public extension JSONDecoder.DateDecodingStrategy {
    
    @available(iOS 11.0, *)
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                  debugDescription: "Invalid date: " + string)
        }
        return date
    }
    
}
