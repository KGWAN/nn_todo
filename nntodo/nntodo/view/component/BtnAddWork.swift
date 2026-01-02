//
//  BtnAdd.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/13/25.
//

import SwiftUI

struct BtnAddWork: View {
    @EnvironmentObject var theme: ThemeManager
    let img: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(img)
                .frame(width: 50, height: 50)
                .padding(5)
                .foregroundStyle(theme.foregroundReversal)
                .background(theme.btnBgActived)
                .cornerRadius(30)
        }
    }
}

#Preview {
    BtnAddWork(img: "img") {
        
    }.environmentObject(ThemeManager())
}
