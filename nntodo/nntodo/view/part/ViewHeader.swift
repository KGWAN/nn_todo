//
//  ViewHeader.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/10/25.
//

import SwiftUI

struct ViewHeader: View {
    // init
    let title: String
    // environment
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
                dismiss()
            } label: {
                Text("<")
                    .frame(width: 20, height: 20)
                    .foregroundStyle(theme.foreground)
                    .padding(5)
                    .background(theme.areaTestOrange)
                    .cornerRadius(15)
            }
            Text(title)
                .bold(true)
                .foregroundStyle(theme.foreground)
                .background(theme.areaTestYellow)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .background(theme.areaTestRed)
    }
}

#Preview {
    ViewHeader(title: "TITLE")
        .environmentObject(ThemeManager().getPreviewThemeManager())
}
