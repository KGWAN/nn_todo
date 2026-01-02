//
//  Dummy.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/20/25.
//

import Foundation

struct Dummy {
    static let listMenuBottom: [String] = ["work", "calendar", "mine"]
    static let listMenu: [String] = ["Star work", "Kategorie", "Theme", "Widget", "Setting"]
    static let listKategorie: [String] = ["All", "Work", "Personal", "Study"]
    
    ///
    /// [ menu info ]
    /// action {
    ///     popup > popup 열기
    ///     swtich > on/off
    ///     confirm_popup > 확인창
    /// }
    ///
    static let listMenuOtherViewWork: [[String: Any]] = [
        [
            "code": "M00",
            "name": "manege kategorie",
            "action": "full_screen",
        ],[
            "code": "M01",
            "name": "search",
            "action": "",
        ],[
            "code": "M02",
            "name": "sort work",
            "action": "",
        ],[
            "code": "M03",
            "name": "print",
            "action": "",
        ],[
            "code": "M04",
            "name": "open all",
            "action": "",
        ]
    ]
    static let listMenuOtherViewKategorie: [[String: Any]] = [
        [
            "code": "K00",
            "name": "수정",
            "action": "popup",
        ],[
            "code": "K01",
            "name": "숨김",
            "action": "switch",
            "other_text": "보이기"
        ],[
            "code": "K02",
            "name": "삭제",
            "action": "confirm_popup",
        ]
    ]
    static let listMenuWork: [[String: Any]] = [
        [
            "code": "D00",
            "name": "work detail page",
            "action": "full_screen",
        ]
    ]
    
    static let listColorKategorie: [String] = ["#ff0000", "#ff8c00", "#ffd700", "#228b22", "#0000ff", "#191970", "#9400d3"]
    static let colorDefaltKategorie: String = "#696969"
}
