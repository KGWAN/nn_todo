//
//  TypeMenu.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/24/25.
//

import Foundation

struct TypeMenu: Identifiable {
    // 자동 기입
    let id: UUID
    // 필수
    let code: String
    let name: String
    let action: String
    // 필수값은 아님
    let otherText: String?
    let description: String?
    let icon: String?
    
    init?(dictionary: [String: Any]) {
        // 필수 값 검증
        guard let code = dictionary["code"] as? String,
              let name = dictionary["name"] as? String,
              let action = dictionary["action"] as? String else {
            return nil
        }
        
        self.id = UUID()
        self.code = code
        self.name = name
        self.action = action
        self.description = dictionary["description"] as? String
        self.icon = dictionary["icon"] as? String
        self.otherText = dictionary["other_text"] as? String
    }
}

enum TypeMode {
    case VIEW
    case CREATE
    case MODIFY
    case DELETE
}
