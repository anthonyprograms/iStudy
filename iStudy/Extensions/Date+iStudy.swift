//
//  Date+iStudy.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import Foundation

extension Date {
    var currentTimestamp: Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
}
