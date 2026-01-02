//
//  ContainerPicker.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/30/25.
//

import SwiftUI

struct ContainerPicker<T: Identifiable, C: View, L: View>: View {
    // init
    let list: [T]
    let onSelected: (T) -> Void
    let popup: (T) -> C
    let labelBtn: () -> L
    
    init(list: [T],
        onSelected: @escaping (T) -> Void,
        @ViewBuilder popup: @escaping (T) -> C,
        @ViewBuilder labelBtn: @escaping () -> L) {
        self.list = list
        self.onSelected = onSelected
        self.popup = popup
        self.labelBtn = labelBtn
    }
    // state
    @State var isOpenedPopup: Bool = false
    // environment
    @EnvironmentObject var theme: ThemeManager
    
    
    var body: some View {
        ZStack {
            ViewDim(isShowingPopup: $isOpenedPopup)
            BtnPicker($isOpenedPopup) {
                labelBtn()
            }
        }
        .overlayPreferenceValue(BoundPreferenceKey.self) { bound in
            GeometryReader { geo in
                if let bound, isOpenedPopup {
                    let rect = geo[bound]
                    
                    PopupPicker(
                        list,
                        onSelected: { item in
                            onSelected(item)
                            isOpenedPopup = false
                        }, content: popup
                    )
                    .background(theme.areaTestOrange)
                    .position(
                        x: rect.midX,
                        y: rect.maxY + 10
                    )
                    .zIndex(100)
                }
            }
        }
    }
}

#Preview {
    let list = Dummy.listMenuOtherViewWork.compactMap {
        TypeMenu(dictionary: $0)
    }
    
    ContainerPicker(
        list: list,
        onSelected: { item in
            print("item(\(item)) was selected.")
        }, popup: { item in
            Text(item.name)
        }, labelBtn: {
            Text("img")
        }
    )
    .environmentObject(ThemeManager().getPreviewThemeManager())
}
