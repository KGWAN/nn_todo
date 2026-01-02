//
//  ThemeManager.swift
//  nn
//
//  Created by JUNGGWAN KIM on 8/12/25.
//

import Foundation
import SwiftUICore
import UIKit

class ThemeManager: ObservableObject {
    @Published private var currentTheme: Theme = .NONE
    @Published var foreground: Color = .black
    @Published var foregroundReversal: Color = .white
    @Published var foregroundWeek: Color = Color(hex: "#aaaaaa")
    @Published var background: Color = .white
    @Published var backgroundReversal: Color = .black
    @Published var bgArea: Color = Color(hex: "#eeeeee")
    @Published var bgAreaCombo: Color = Color(hex: "#cccccc")
    @Published var btnBgDeactived: Color = Color(hex: "#eeeeee")
    @Published var btnBgActived: Color = Color(hex: "#bbbbbb")
    @Published var btnBgArea: Color = Color(hex: "#dddddd")
    @Published var shadow: Color = Color(hex: "#cccccc")
    
    /// 배경이 존재하지 않는 곳에 사용할것
    @Published var areaTestRed: Color = Color.clear
    @Published var areaTestOrange: Color = Color.clear
    @Published var areaTestYellow: Color = Color.clear
    @Published var areaTestBlue: Color = Color.clear
    
    

    func changeTheme(theme: Theme) {
        let style = UIScreen.main.traitCollection.userInterfaceStyle
        switch theme {
        case .SYSTEM, .NONE:
            if style == .light {
                changeTheme(theme: .LIGHT)
            } else {
                changeTheme(theme: .DARK)
            }
        case .LIGHT:
            background = .white
            foreground = .black
            foregroundReversal = .white
            btnBgDeactived = Color(hex: "#eeeeee")
            btnBgActived = Color(hex: "#bbbbbb")
            btnBgArea = Color(hex: "#dddddd")
            bgAreaCombo = Color(hex: "#cccccc")
        case .DARK:
            background = .black
            foreground = .white
            foregroundReversal = .black
            btnBgDeactived = Color(hex: "#333333")
            btnBgActived = Color(hex: "#bbbbbb")
            btnBgArea = Color(hex: "#dddddd")
            bgAreaCombo = Color(hex: "#cccccc")
        case .TEST:
            areaTestRed = .red
            areaTestOrange = .orange
            areaTestYellow = .yellow
            areaTestBlue = .blue
        }
        
        currentTheme = theme
    }
    
    private func getTheme() -> Theme {
        if currentTheme == .NONE {
            // checkTheme() 저장된 테마로 테마 변경
            changeTheme(theme: .SYSTEM)
        }
        return currentTheme
    }
    
    func getPreviewThemeManager() -> ThemeManager {
        changeTheme(theme: .TEST)
        return self
    }
}


