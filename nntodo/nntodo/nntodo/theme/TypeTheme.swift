//
//  TypeTheme.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/12/25.
//

import Foundation

enum Theme: String, Identifiable, CaseIterable {
    case SYSTEM = "System"
    case LIGHT = "Light"
    case DARK = "Dark"
    case TEST = "Test"
    case NONE = "None"
    
    var id: Int {
        hashValue
    }
}
