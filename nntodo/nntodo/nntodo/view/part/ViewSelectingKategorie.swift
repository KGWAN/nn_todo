//
//  ViewSelectingKategorie.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/17/25.
//

import SwiftUI

struct ViewSelectingKategorie: View {
    // binding
    @Binding var currentKategorie: UUID?
    // state
    @State private var otherPopupSize: CGSize = .zero // 팝업의 크기를 측정하기 위함
    // environment
    @EnvironmentObject var theme: ThemeManager
    @Environment(\.managedObjectContext) private var viewContext
    // core data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Kategorie.sort_num, ascending: true)],
        animation: .default
    )
    private var listKategorie: FetchedResults<Kategorie>
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(listKategorie, id: \.self) { kategorie in
                    ItemTabKategorie(
                        text: kategorie.name,
                        isActive: Binding(get: {
                            currentKategorie == kategorie.id
                        }, set: { _ in
                        })
                    ).onTapGesture {
                        currentKategorie = kategorie.id
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            if listKategorie.isEmpty {
                PersistenceController.shared.createInitialKategorieData(viewContext)
                PersistenceController.shared.save(viewContext)
                print("listKategorie >> \(listKategorie.count)")
            }
            if currentKategorie == nil {
                currentKategorie = listKategorie.first!.id
            }
        }.onChange(of: listKategorie.count) { old, new in
            guard !listKategorie.isEmpty else { return }
            print("aaa1")
            currentKategorie = listKategorie.first!.id
        }
    }
}

#Preview {
    @Previewable @State var kategorie: UUID? = nil
    
    ViewSelectingKategorie(currentKategorie: $kategorie)
        .environmentObject(ThemeManager().getPreviewThemeManager())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
