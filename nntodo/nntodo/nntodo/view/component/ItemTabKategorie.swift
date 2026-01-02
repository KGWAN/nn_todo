//
//  BtnKategorie.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/12/25.
//

import SwiftUI

struct ItemTabKategorie: View {
    // init
    var text: String
    // binding
    @Binding var isActive: Bool
    // environment
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        Text(text)
            .padding(Edge.Set.horizontal, 20)
            .padding(Edge.Set.vertical, 5)
            .foregroundStyle(isActive == true ? theme.foregroundReversal : theme.foreground)
            .background(isActive == true ? theme.btnBgActived : theme.btnBgDeactived)
            .cornerRadius(20)
    }
}

#Preview {
    @Previewable @State var isActiveTrue: Bool = true
    @Previewable @State var isActiveFalse: Bool = false
    ItemTabKategorie(text: "Kategorie", isActive: $isActiveTrue).environmentObject(ThemeManager())
    ItemTabKategorie(text: "Kategorie", isActive: $isActiveFalse).environmentObject(ThemeManager())
}
