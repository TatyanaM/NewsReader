//
//  URL+Validation.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 9/5/19.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import Foundation


extension URL {
    /// Helper method for check a string potentially containing a url. Returns true if given string is a valid URL and false otherwise
    var isValidURL: Bool {
        let urlString = self.absoluteString
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: urlString, options: [], range: NSRange(location: 0, length: urlString.utf16.count)) {
            return match.range.length == urlString.utf16.count
        } else {
            return false
        }
    }
}
