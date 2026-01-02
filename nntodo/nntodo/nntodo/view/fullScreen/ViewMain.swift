//
//  ViewMain.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/12/25.
//

import SwiftUI


struct ViewMain: View {
    // constant
    private let keyLog = "view_main"
    private let listMenu: [String] = Dummy.listMenuBottom
    private let listMenuOther: [TypeMenu] = Dummy.listMenuOtherViewWork.compactMap {
        TypeMenu(dictionary: $0)
    }
    // envirionment
    @EnvironmentObject var theme: ThemeManager
    // state
    @State var currentMenu: String = "work"
    @State var isShowingPopupAddWork: Bool = false
    @State var isShowingPopupSideMenu: Bool = false
    @State var openedMenu: TypeMenu? = nil
    @State var selectedWork: Work? = nil
    
    var body: some View {
        ZStack {
            VStack {
                // 보여지는 화면
                ZStack(alignment: .bottom) {
                    VStack {
                        switch currentMenu {
                        case "work":
                            ViewWork(listMenuOther: listMenuOther) {
                                switch $0.action {
                                case "full_screen":
                                    // M00: 카테고리관리
                                    // D00: 카테고리관리
                                    openedMenu = $0
                                    if let work = $1?["work"] as? Work {
                                        selectedWork = work
                                    }
                                default:
                                    Log.logDebug("It's not defined action(code:\($0)).", key: keyLog)
                                }
                            }
                        default:
                            Spacer()
                            Text("Coming soon!")
                            Spacer()
                        }
                    }
                    if ["work", "calendar"].contains(currentMenu) {
                        HStack {
                            Spacer()
                            BtnAddWork(img: "img") {
                                isShowingPopupAddWork = true
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                // 하단 버튼
                HStack() {
                    Button(action: {
                        // 사이드 메뉴 오픈
                        isShowingPopupSideMenu = true
                    }, label: {
                        Text("img")
                            .frame(width: 40, height: 40)
                            .padding(5)
                            .foregroundStyle(theme.foreground)
                            .background(theme.btnBgArea)
                            .cornerRadius(10)
                    })
                    Spacer()
                    ForEach(listMenu.indices, id: \.self) { i in
                        ItemMenu(
                            text: listMenu[i],
                            isActive: Binding(get: {
                                currentMenu == listMenu[i]
                            }, set: { _ in
                            })
                        ).onTapGesture {
                            currentMenu = listMenu[i]
                        }
                        if i != listMenu.count - 1 {
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .overlay(
                    // 위쪽 그림자 효과
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.15), // 그림자 색상
                            Color.clear
                        ]),
                        startPoint: .top,
                        endPoint: .center
                    )
                    .frame(height: 6) // 그림자 영역 높이 조정
                    , alignment: .top
                )
            }
            if isShowingPopupAddWork {
                VStack {
                    ViewDim(isShowingPopup: $isShowingPopupAddWork)
                    PopupAddWork()
                }
            }
            if isShowingPopupSideMenu {
                HStack(spacing: 0) {
                    PopupSideMenu()
                    ViewDim(isShowingPopup: $isShowingPopupSideMenu)
                }
            }
        }
        .fullScreenCover(item: $openedMenu) {
            if $0.action.elementsEqual("full_screen") {
                switch $0.code {
                case "M00": // 카테고리 관리
                    ViewKategorie()
                case "D00": // 작업 상세
                    if let work = selectedWork {
                        ViewDetailWork(id: work.id)
                    }
                default:
                    ViewErr() // errer
                }
            }
        }
    }
}

#Preview {
    ViewMain()
        .environmentObject(ThemeManager().getPreviewThemeManager())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
