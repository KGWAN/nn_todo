//
//  ContainerPicker.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/30/25.
//

import SwiftUI

enum PickerAlignment {
    case left
    case right
}

struct ContainerPicker<T: Identifiable, C: View>: ViewModifier {
    // init
    let alignment: PickerAlignment
    let list: [T]
    let onSelected: (T) -> Void
    let popup: (T) -> C
//    let labelBtn: () -> L
    
    init(_ alignment: PickerAlignment = .left,
        list: [T],
        onSelected: @escaping (T) -> Void,
        @ViewBuilder popup: @escaping (T) -> C,
//        @ViewBuilder labelBtn: @escaping () -> L
    ) {
        self.alignment = alignment
        self.list = list
        self.onSelected = onSelected
        self.popup = popup
//        self.labelBtn = labelBtn
    }
    // constant
    private let offset: CGFloat = 8
    // state
    @State var isOpenedPopup: Bool = false
    @State private var popupSize: CGSize = .zero
    @State private var rect: CGRect = .zero
    // environment
    @EnvironmentObject var theme: ThemeManager
    // types
    
    
    
//    var body: some View {
    func body(content: Content) -> some View {
        ZStack(alignment: .topLeading) {
//            ViewDim(isShowingPopup: $isOpenedPopup)
            BtnPicker($isOpenedPopup) {
                content
//                labelBtn()
//                    .background(theme.areaTestOrange)
            }
            
            if isOpenedPopup {
                PopupPicker(
                    list,
                    onSelected: { item in
                        onSelected(item)
                        isOpenedPopup = false
                    }, content: popup
                )
                .background(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    popupSize = geo.size
                                }
                                .onChange(of: geo.size) { new, old in
                                    popupSize = new
                                }
                        }
                    )
                .background(theme.areaTestOrange)
//                .frame(
//                    maxWidth: .infinity,
//                    maxHeight: .infinity,
//                    alignment: .topLeading
//                    )
//                        alignment: alignment == .left ? .topLeading : .topTrailing)
                .offset(
                    x: popupXOffset(rect),
                    y: rect.maxY + offset
                )
                .zIndex(100)
            }
        }
        .coordinateSpace(name: "ContainerPickerSpace")
        .overlayPreferenceValue(BoundPreferenceKey.self) { bound in
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        if let bound {
                            rect = geo[bound]
                        }
                    }
            }
        }
    }
    
    
    private func popupXOffset(_ rect: CGRect) -> CGFloat {
        switch alignment {
        case .left:
            // 버튼 left == 팝업 left
            return rect.minX

        case .right:
            // 버튼 right == 팝업 right
            return rect.maxX - popupSize.width
        }
    }
}

#Preview {
    let list = Dummy.listMenuOtherViewWork.compactMap {
        TypeMenu(dictionary: $0)
    }
    
    
//    ContainerPicker(
//        .left,
//        list: list,
//        onSelected: { item in
//            print("item(\(item)) was selected.")
//        }, popup: { item in
//            Text(item.name)
//        }, labelBtn: {
//            Text("img")
//        }
//    )
//    .environmentObject(ThemeManager().getPreviewThemeManager())
    Text("Preview")
        .containerPicker(
            alignment: PickerAlignment.left,
            list: list,
            onSelected: { item in
                print("\(item)")
            }, popup: { item in
                Text("item(\(item.name))")
            }
        )
        .environmentObject(ThemeManager().getPreviewThemeManager())
}
