//
//  ViewWork.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/13/25.
//

import SwiftUI

struct ViewWork: View {
    // init
    let listMenuOther: [TypeMenu]
    var callAction: ((TypeMenu, Dictionary<String, Any>?) -> Void)? = nil// 메인 화면에 함수 호출을 요청하는 경우
    // environment
    @EnvironmentObject var theme: ThemeManager
    // state
    @State var currentKategorie: UUID? = nil
    @State var isShowingPopupOther: Bool = false
    @State var listTodo: [Work] = []
    @State var frameBtnPopupOther: CGRect = .zero
    @State var sizePopupOther: CGSize = .zero
    // value
    let codeMenu: TypeMenu? = Dummy.listMenuWork.compactMap {
        TypeMenu(dictionary: $0)
    }.filter { $0.code == "D00" }.first
    
    
    var body: some View {
        ZStack {
            VStack {
                ///
                /// header
                ///
                HStack(alignment: .center) {
                    ViewSelectingKategorie(currentKategorie: $currentKategorie)
                    Spacer()
                    Button {
                        // open picker
                        isShowingPopupOther.toggle()
                    } label: {
                        Text("etc")
                            .frame(width: 15, height: 15)
                            .padding(5)
                            .foregroundStyle(theme.foreground)
                            .background(theme.btnBgArea)
                            .cornerRadius(15)
                    }
                    .background(
                        GeometryReader { proxy in
                            theme.areaTestOrange.onAppear {
                                frameBtnPopupOther = proxy.frame(in: .global)
                            }
                            .onChange(of: proxy.frame(in: .global)) { oldValue, newValue in
                                frameBtnPopupOther = newValue
                            }
                        }
                    )
                    .overlay {
                        if isShowingPopupOther {
                            PopupOther(list: listMenuOther) { code in
                                isShowingPopupOther = false
                                if let action = callAction {
                                    action(code, nil)
                                }
                            }
                            .background(
                                GeometryReader { proxy in
                                    theme.areaTestRed.onAppear {
                                        sizePopupOther = proxy.size
                                    }
                                    .onChange(of: proxy.size) { oldValue, newValue in
                                        sizePopupOther = newValue
                                    }
                                }
                            )
                            .fixedSize()
                            .offset(
                                x: frameBtnPopupOther.width/2 - sizePopupOther.width/2,
                                y: frameBtnPopupOther.height/2 + sizePopupOther.height/2 + 10
                            )
                        }
                    }
                }
                .padding(.bottom, 10)
                .zIndex(1)
                
                ///
                /// work list
                ///
                if !listTodo.isEmpty {
                    ForEach(listTodo, id: \.self) { work in
                        ItemTodo(text: work.name) {
                            if let code = codeMenu, let action = callAction {
                                let arguement: Dictionary<String, Any> = ["work": work]
                                action(code, arguement)
                            }
                        }
                    }
                    Spacer()
                } else {
                    Spacer()
                    Text("Nothing to do.")
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    let listMenuOther: [TypeMenu] = Dummy.listMenuOtherViewWork.compactMap {
        TypeMenu(dictionary: $0)
    }
    
    ViewWork(listMenuOther: listMenuOther)
        .environmentObject(ThemeManager())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
