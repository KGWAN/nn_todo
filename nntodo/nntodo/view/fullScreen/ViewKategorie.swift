//
//  ViewKategorie.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/25/25.
//

import SwiftUI
import CoreData

struct ViewKategorie: View {
    // constant
    private let TITLE: String = "카테고리 관리"
    private let TEXT_GUIDE: String = """
        카테고리를 추가해서 할 일을 분류하여 관리할 수 있습니다.
        실행시 첫 번째 카테고리가 선택되어 보입니다.
    """
    private let KEY_LOG: String = "ViewKategorie"
    // environment
    @EnvironmentObject var theme: ThemeManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    // state
    @State private var isOpenedPopupDetailKategorie: Bool = false // 카테고리 상세 팝업 show/hide
    @State var mode: TypeMode = .VIEW   // 현재 모드, default = view
    @State var selectedKategorie: Kategorie? = nil  // edit 중인 카테고리
    @State private var isShowingPopupOther: Bool = false // 기타 동작 팝업 show/hide
    @State private var frameSelectedBtnPopupOther: CGRect = .zero // 팝업의 기준 위치
    @State private var framePopupOther: CGRect = .zero // 팝업의 기준 위치
    @State private var isShowingPopupConfirm: Bool = false // 확인 팝업 show/hide
    @State var listItem: [Kategorie] = []   // 재정렬의 사용될 변수
    // value
    private let listMenuOther: [TypeMenu] = Dummy.listMenuOtherViewKategorie.compactMap {
        TypeMenu(dictionary: $0)
    }
    // core data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Kategorie.sort_num, ascending: true)],
        animation: .default
    )
    private var listKategorie: FetchedResults<Kategorie>
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ViewHeader(title: TITLE)
                Text(TEXT_GUIDE)
                    .font(.system(size: 14))
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .foregroundStyle(theme.foregroundWeek)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(theme.bgArea)
                List {
                    Group {
                        ForEach($listItem, id: \.id) { $item in
                            ItemKategorie(
                                data: item,
                                isShowingPopupOther: $isShowingPopupOther,
                                frameSelectedBtn: $frameSelectedBtnPopupOther,
                                selectedKategorie: $selectedKategorie
                            )
                        }
                        .onMove(perform: move)
                        
                        Button {
                            self.mode = .CREATE
                            selectedKategorie = Kategorie.createNewKategorie(viewContext)
                            selectedKategorie?.sort_num = String(listKategorie.count)
                            self.isOpenedPopupDetailKategorie = true
                        } label: {
                            HStack(alignment: .center, spacing: 20) {
                                Text("+")
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(theme.foreground)
                                Text("새로 만들기")
                                    .padding(Edge.Set.vertical, 5)
                                    .foregroundStyle(theme.foreground)
                                    .background(theme.areaTestOrange)
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 20)
                            .background(theme.btnBgArea)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listStyle(.plain)
                .onAppear {
                    listItem = listKategorie.map { $0 }
                }
                .onChange(of: listKategorie.count) { old, new in
                    listItem.removeAll()
                    listItem = listKategorie.map { $0 }
                }
            }
            
            if isShowingPopupOther {
                ViewDim(isShowingPopup: $isShowingPopupOther, opacity: 0.001)
                PopupOther(
                    list: listMenuOther,
                    onSelected: {
                        switch $0.code {
                        case "K00": // 수정
                            self.mode = .MODIFY
                            self.isOpenedPopupDetailKategorie = true
                        case "K01": // 숨김/보이기
                            selectedKategorie?.is_hidden.toggle()
                            PersistenceController.shared.save(viewContext)
                        case "K02":
                            isShowingPopupConfirm = true
                            Log.logDebug("deleated Kategorie: \(String(describing: selectedKategorie))")
                        default:
                            Log.logDebug("It's not defined action(code:\($0)).", key: KEY_LOG)
                        }
                        isShowingPopupOther = false
                    },
                    isActive: !(selectedKategorie?.is_hidden ?? false)
                )
                .background(
                    GeometryReader { proxy in
                        Color.clear.onAppear {
                            framePopupOther = proxy.frame(in: .global)
                            print("framePopupOther >>> \(framePopupOther)")
                        }
                        .onChange(of: proxy.frame(in: .global)) { oldValue, newValue in
                            framePopupOther = newValue
                        }
                    }
                )
                .fixedSize()
                .position( // position 및 geometry로 측정해서 계산을 사용하는게 어려움
                    x: frameSelectedBtnPopupOther.maxX - framePopupOther.width/2,
                    y: frameSelectedBtnPopupOther.maxY
                )
            }
            
            if isOpenedPopupDetailKategorie {
                PopupAddKategorie(
                    isPresented: $isOpenedPopupDetailKategorie,
                    selectedKategorie: $selectedKategorie,
                    mode: mode
                )
            }
            
            if let kategorie = selectedKategorie {
                if isShowingPopupConfirm {
                    PopupConfirm(
                        title: "카테고리(\(kategorie.name))를 삭제하시겠습니까?",
                        message: "이 범주의 모든 작업이 삭제됩니다.",
                        textBtnCancle: "취소",
                        textBtnOk: "삭제",
                        actionBtnOk: {
                            delete(kategorie)
                        },
                        isPresented: $isShowingPopupConfirm
                    )
                }
            }
        }
        .onChange(of: isOpenedPopupDetailKategorie, { _, newValue in
            if !newValue {
                selectedKategorie = nil
            }
        })
        .onChange(of: isShowingPopupConfirm) { _, newValue in
            if !newValue {
                selectedKategorie = nil
            }
        }
        .onChange(of: isShowingPopupOther) { _, newValue in
            if !newValue {
                if isOpenedPopupDetailKategorie || isShowingPopupConfirm {
                    return
                }
                selectedKategorie = nil
            }
        }
    }
    
    
// function
    // 카테고리 삭제
    func delete(_ kategorie: Kategorie) {
        viewContext.delete(kategorie)
                
        // 2. Context 저장
        do {
            try viewContext.save()
        } catch {
            // 에러 처리
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    // 카테고리 이동
    func move(from source: IndexSet, to destination: Int) {
        // 1. @State 변수인 listItem의 순서를 변경합니다.
        listItem.move(fromOffsets: source, toOffset: destination)
        
        // 2. 변경된 순서를 Core Data의 'sort_num'에 반영하고 저장합니다.
        updateSortOrder()
    }

    // 변경된 listItem의 순서를 Core Data의 sort_num에 반영하는 함수
    func updateSortOrder() {
        for index in listItem.indices {
            let item = listItem[index]
            // 인덱스를 Core Data의 정렬 번호(sort_num)로 업데이트합니다.
            item.sort_num = String(index)
        }
        
        // Core Data Context 저장
        PersistenceController.shared.save(viewContext)
    }
}

#Preview {
    ViewKategorie()
        .environmentObject(ThemeManager().getPreviewThemeManager())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
