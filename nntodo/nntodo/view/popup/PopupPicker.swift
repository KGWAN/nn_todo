//
//  PopupOther.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/19/25.
//

import SwiftUI

///
/// Custom picker의 Popup
///
struct PopupPicker<T: Identifiable ,C: View>: View {
    // init
    let list: [T]
    let onSelected: (T) -> Void
    let content: (T) -> C
    init(_ list: [T],
         onSelected: @escaping (T) -> Void,
         @ViewBuilder content:  @escaping (T) -> C) {
        self.list = list
        self.onSelected = onSelected
        self.content = content
    }
    // constant
    private let spacing: CGFloat = 10
    private let paddingVertical: CGFloat = 5
    private let paddingHorizontal: CGFloat = 5
    private let cornerRadius: CGFloat = 5
    private let shadowRadius: CGFloat = 5
    // environment
    @EnvironmentObject var theme: ThemeManager
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(list) { item in
                Button {
                    // 기타 기능
                    onSelected(item)
                } label: {
                    content(item)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding(.vertical, paddingVertical)
        .padding(.horizontal, paddingHorizontal)
        .background(theme.background)
        .cornerRadius(cornerRadius)
        .shadow(color: theme.shadow, radius: shadowRadius)
    }
}

#Preview {
    let list = Dummy.listMenuOtherViewWork.compactMap {
        TypeMenu(dictionary: $0)
    }
//    let list2 = Dummy.listMenuOtherViewKategorie.compactMap {
//        TypeMenu(dictionary: $0)
//    }
    
    
    PopupPicker(list) { item in
            print("item(\(item)) was selected.")
        } content: { item in
            Text(item.name)
        }.environmentObject(ThemeManager().getPreviewThemeManager())
}
