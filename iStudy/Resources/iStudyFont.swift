//
//  iStudyFont.swift
//  iStudy
//
//  Created by Anthony Williams on 3/22/24.
//

import SwiftUI

enum iStudyFont {
    /// 12.0
    static let xSmall = Font.system(size: 12.0)
    
    /// 15.0
    static let small = Font.system(size: 15.0)
    
    /// 16.0
    static let medium = Font.system(size: 16.0)
    
    /// 20.0
    static let large = Font.system(size: 20.0)
    
    /// 24.0
    static let xLarge = Font.system(size: 24.0)
    
    /// 20,0 + bold
    static let question = Font.system(size: 20.0, weight: .bold)
}
