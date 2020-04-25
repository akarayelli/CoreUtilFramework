//  FormatterExtension.swift
//  CoreUtilFramework 
//
//  User: Alican.Karayelli
//  Date: 26.04.2020
//  Time: 01:22

import Foundation

@available(iOS 10.0, *)
public extension Formatter {
    @available(iOS 11.0, *)
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}


@available(iOS 10.0, *)
public extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}
