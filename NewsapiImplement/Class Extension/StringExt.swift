//
//  StringExt.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/25/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import Foundation

extension String {
    var isUsername: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._]{3,64}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
}
