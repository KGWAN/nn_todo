//
//  BtnOnOrOff.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/2/25.
//

import SwiftUI

struct BtnSave: View {
    var action: () -> Void
    @Binding var isActive: Bool
    
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("저장")
                .foregroundStyle(isActive ? theme.foreground : theme.foregroundWeek)
                .padding(.vertical, 5)
                .padding(.leading, 10)
        }
        .disabled(!isActive)
    }
}

#Preview {
    @Previewable @State var on: Bool = true
    @Previewable @State var off: Bool = false
    
    // 활성화 상태
    BtnSave(action: {
        
    }, isActive: $on)
    .environmentObject(ThemeManager().getPreviewThemeManager())
    
    // 비활성화 상태
    BtnSave(action: {
        
    }, isActive: $off)
    .environmentObject(ThemeManager().getPreviewThemeManager())
}
