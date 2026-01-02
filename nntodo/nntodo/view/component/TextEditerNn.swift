//
//  TextEditerNn.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/26/25.
//

import SwiftUI

struct TextEditerNn: View {
    // init
    let placeholder: String
    @Binding var text: String
    // value
    var padding: CGFloat = 20
    var maxLength: Int = 100
    // environment
    @EnvironmentObject var theme: ThemeManager
    // state
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .foregroundStyle(theme.foreground)
                .scrollContentBackground(.hidden)
                .focused($isFocused)
                .onChange(of: text) { oldValue, newValue in
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
            if (text.isEmpty && !isFocused) {
                Text(placeholder)
                    .foregroundStyle(theme.foregroundWeek)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(padding)
        .background(theme.bgArea)
        .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    TextEditerNn(placeholder: "placeholder.", text: $text)
        .environmentObject(ThemeManager().getPreviewThemeManager())
}
