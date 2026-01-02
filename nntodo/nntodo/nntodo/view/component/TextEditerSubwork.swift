//
//  TextEditerNn.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/26/25.
//

import SwiftUI

struct TextEditerSubwork: View {
    // init
    let placeholder: String
    @Binding var text: String
    @Binding var isChecked: Bool
    // value
    var maxLength: Int = 20
    // environment
    @EnvironmentObject var theme: ThemeManager
    // state
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if (text.isEmpty && !isFocused) {
                Text(placeholder)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 5)
                    .foregroundStyle(theme.foregroundWeek)
                    .strikethrough(isChecked)
                    .allowsHitTesting(false)
            } else {
                Text(text)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 5)
                    .foregroundStyle(!isChecked ? theme.foreground : theme.foregroundWeek)
                    .strikethrough(isChecked)
                    .allowsHitTesting(false)
            }
            
            TextEditor(text: $text)
                .foregroundStyle(Color.clear)
                .scrollContentBackground(.hidden)
                .focused($isFocused)
                .onChange(of: text) { oldValue, newValue in
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .background(theme.areaTestOrange)
        .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    TextEditerSubwork(
        placeholder: "placeholder.",
        text: $text,
        isChecked: Binding(get: {
            false
        }, set: { v in
            
        })
    )
    .environmentObject(ThemeManager().getPreviewThemeManager())
    TextEditerSubwork(
        placeholder: "placeholder.",
        text: $text,
        isChecked: Binding(get: {
            true
        }, set: { v in
            
        })
    )
    .environmentObject(ThemeManager().getPreviewThemeManager())
}
