//
//  IntroView.swift
//  nn
//
//  Created by JUNGGWAN KIM on 7/23/25.
//

import SwiftUI

struct ViewIntro: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var theme: ThemeManager
    var onFinish: (String) -> Void // Intro가 끝난 시점의 콜백
    @State var resultCode = "-1"
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Kategorie.sort_num, ascending: true)],
        animation: .default
    )
    private var allKategorie: FetchedResults<Kategorie>
    
    var body: some View {
        VStack {
            Spacer()
            Text("nn")
                .font(.largeTitle)
                .bold(true)
                .foregroundStyle(theme.foreground)
            Spacer()
            Text("Intro")
                .foregroundStyle(theme.foreground)
        }
        .padding()
        .background(theme.background)
        .onAppear {
            // 사전준비
            if allKategorie.isEmpty {
                PersistenceController.shared.createInitialData(viewContext) {
                    resultCode = "0000"
                    onFinish(resultCode)
                }
            } else {
                resultCode = "0000"
                onFinish(resultCode)
            }
        }
    }
    
    
}

#Preview {
    ViewIntro() {_ in 
    }
    .environmentObject(ThemeManager())
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
