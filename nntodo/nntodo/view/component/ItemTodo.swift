//
//  ItemTodo.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/20/25.
//

import SwiftUI

struct ItemTodo: View {
    // init
    @State var text: String
    let onLoadDetail: () -> Void
    // environment
    @EnvironmentObject var theme: ThemeManager
    // state
    @State var isChecked: Bool = false
    
    var body: some View {
        HStack {
            Button {
                isChecked.toggle()
            } label: {
                Text("img")
                    .frame(width: 40, height: 40)
                    .padding(5)
                    .foregroundStyle(!isChecked ? theme.foreground : theme.foregroundReversal)
                    .background(!isChecked ? theme.btnBgDeactived : theme.btnBgActived)
                    .cornerRadius(10)
            }
            
            Button {
                onLoadDetail()
            } label: {
                Text(text)
                    .foregroundStyle(!isChecked ? theme.foreground : theme.foregroundWeek)
                    .strikethrough(isChecked)
                Spacer()
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .background(theme.btnBgArea)
        .cornerRadius(10)
    }
}

#Preview {
    ItemTodo(text: "Testing app, nntodo.") {
        print("Todo's detail page was opened.")
    }
    .environmentObject(ThemeManager().getPreviewThemeManager())
    ItemTodo(text: "Testing app, nntodo.") {
        print("Todo's detail page was opened.")
    }
    .environmentObject(ThemeManager().getPreviewThemeManager())
}
