//
//  BtnMenu.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/13/25.
//

import SwiftUI

struct ItemMenu: View {
    @EnvironmentObject var theme: ThemeManager
    var text: String
    @Binding var isActive: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Text("img")
                .frame(width: 40, height: 40)
                .padding(5)
                .foregroundStyle(isActive == true ? theme.foregroundReversal : theme.foreground)
                .background(isActive == true ? theme.btnBgActived : theme.btnBgDeactived)
                .cornerRadius(10)
            Text(text)
        }
    }
}

#Preview {
    @Previewable @State var isActiveTrue: Bool = true
    @Previewable @State var isActiveFalse: Bool = false
    ItemMenu(text: "Menu", isActive: $isActiveTrue).environmentObject(ThemeManager())
    ItemMenu(text: "Menu", isActive: $isActiveFalse).environmentObject(ThemeManager())
}
