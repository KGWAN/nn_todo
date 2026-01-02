//
//  BtnKategorie.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/12/25.
//

import SwiftUI
import CoreData

struct ItemKategorie: View {
    // constant
    static let KEY = "ItemKategorie"
    // init
    @State var data: Kategorie                // 표시되는 카테고리
    // binding
    @Binding var isShowingPopupOther: Bool
    @Binding var frameSelectedBtn: CGRect
    @Binding var selectedKategorie: Kategorie?  // 선택된 카테고리
    // environment
    @EnvironmentObject var theme: ThemeManager
    @Environment(\.managedObjectContext) private var viewContext
    
    //TODO: dummy: 구현 예정
    @State var cnt: Int = 0 // 카테고리 별 작업 수
    
    var body: some View {
            HStack(alignment: .center, spacing: 20) {
                Circle()
                    .fill((data.color ?? "").isEmpty ? theme.bgArea : Color(hex: data.color!))
                    .frame(width: 10, height: 10)
                Text(data.name.isEmpty ? "no_name" : data.name)
                    .padding(Edge.Set.vertical, 5)
                    .foregroundStyle(theme.foreground)
                    .background(theme.areaTestOrange)
                Spacer()
                if data.is_hidden {
                    Image(systemName: "eye.slash")
                        .foregroundStyle(theme.foregroundWeek)
                }
                Text("\(cnt)")
                GeometryReader { geometry in
                    Button {
                        // set popup location
                        frameSelectedBtn = geometry.frame(in: .global)
                        print("frameSelectedBtn >>> \(frameSelectedBtn)")
                        // select kategorie
                        selectedKategorie = data
                        // open picker
                        isShowingPopupOther.toggle()
                    } label: {
                        // other action(수정, 숨기기, 삭제)
                        Text("img")
                            .foregroundStyle(theme.foreground)
                    }
                }
                .frame(width: 20, height: 20)
                .background(theme.areaTestBlue)
                .cornerRadius(10)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .background(theme.areaTestRed)
            .onAppear {
                self.cnt = fetchItemCount(context: viewContext)
            }
            .coordinateSpace(name: ItemKategorie.KEY)
        
    }
    
    func fetchItemCount(context: NSManagedObjectContext) -> Int {
        // NSFetchRequest 생성
        let fetchRequest: NSFetchRequest<Work> = Work.fetchRequest()
        // 검색 조건(Predicate) 설정
        let predicate = NSPredicate(format: "kategorie == %@", data.name)
        fetchRequest.predicate = predicate
        do {
            // context의 count(for:) 메서드를 사용하여 개수만 요청
            let count = try context.count(for: fetchRequest)
            // 요청이 성공했음을 확인 (NSNotFound가 아닌 경우)
            if count != NSNotFound {
                return count
            } else {
                // 실패 시 처리 (예: 0 반환 또는 오류 던지기)
                return 0
            }
        } catch {
            // 오류 처리
            Log.logError("Failed to calculate the number of conditional instances", error: error, key: ItemKategorie.KEY)
            return 0
        }
    }
}

#Preview {
    @Previewable @State var data: Kategorie = Kategorie.init(context: PersistenceController.preview.container.viewContext)
    @Previewable @State var isOpenedPopup: Bool = false
    @Previewable @State var frameSelectedBtn: CGRect = .zero
    @Previewable @State var selectedKategorie: Kategorie? = nil
    
    ItemKategorie(data: data, isShowingPopupOther: $isOpenedPopup, frameSelectedBtn: $frameSelectedBtn, selectedKategorie: $selectedKategorie)
        .environmentObject(ThemeManager().getPreviewThemeManager())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
