//
//  ContentView.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var authCode: String = "-1"
    
    var body: some View {
        Group {
            if authCode.elementsEqual("0000") {
                ViewMain()
            } else {
                ViewIntro {resultCode in
                    authCode = resultCode
                }
            }
        }.onChange(of: authCode) { old, new in
            if new == "9999" {
                exit(0)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
}
