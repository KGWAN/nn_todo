//
//  ViewDetailWork.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/18/25.
//

import SwiftUI
import CoreData

struct ViewDetailWork: View {
    // init
    private let id: UUID
    init(id: UUID) {
        self.id = id
        _works = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Work.created_date, ascending: false)],
            predicate: NSPredicate(format: "id == %@", id as CVarArg),
        )
    }
    // core data
    @FetchRequest private var works: FetchedResults<Work>
    // state
    @State private var isOpenedPopupSelectingKategory: Bool = false
    @State private var sortedSubworks: [Subwork]? = nil
    // environment
    @EnvironmentObject var theme: ThemeManager
    @Environment(\.managedObjectContext) private var viewContext
    
    let list = Dummy.listMenuOtherViewWork.compactMap {
        TypeMenu(dictionary: $0)
    }
    
    var body: some View {
        if let work = works.first {
            ZStack(alignment: .top) {
                ScrollView(.vertical) {
                    HStack {
//                        Button {
//                            isOpenedPopupSelectingKategory.toggle()
//                        } label: {
//                            Text("카테고리 없음")
//                                .foregroundStyle(theme.foregroundWeek)
//                                .padding(5)
//                                .background(theme.btnBgArea)
//                                .cornerRadius(20)
//                        }
                        

 
                        Spacer()
                    }
                    TextEditerNn(
                        placeholder: work.name,
                        text: Binding(
                            get: { work.name },
                            set: { new in
                                work.name = new
                            }),
                        padding: 10,
                        maxLength: 20
                    )
                    .frame(height: 60)
                    
                    
                    if let subworks = sortedSubworks, !subworks.isEmpty {
                        ForEach(subworks) { subwork in
                            ItemSubwork(subwork.id) {
                                print("onDelete")
                            }
                        }
                    }
                    Button {
                        // create a new subwork
                        //                        w.addSubwork(viewContext)
                        //                        PersistenceController.shared.save()
                    } label: {
                        Text("+ 하위 작업 추가")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(theme.foreground)
                            .background(theme.areaTestOrange)
                    }
                    .frame(maxWidth: .infinity, minHeight: 20)
                    .padding(.vertical, 10)
                    .background(theme.btnBgArea)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                VStack(alignment: .leading) {
                    ViewHeader(title: "")
                    Text("카테고리 없음")
                        .foregroundStyle(theme.foregroundWeek)
                        .padding(5)
                        .background(theme.btnBgArea)
                        .cornerRadius(20)
                        .containerPicker(
                            alignment: .left,
                            list: list) { item in
                                print("\(item.name)")
                            } popup: { item in
                                Text("\(item.name)")
                            }
                }
            }
            .onAppear {
                
            }
        } else {
            Text("해당 work를 찾을 수 없습니다.")
        }
    }
    
    func fetchWork(id: UUID, context: NSManagedObjectContext) -> Work? {
        let request: NSFetchRequest<Work> = Work.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1

        return try? context.fetch(request).first
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    var data: Work {
        let testWork = Work.createNew(context)
            .addSubwork(context)
            .addSubwork(context)
        return testWork
    }

    ViewDetailWork.init(id: data.id)
        .environmentObject(ThemeManager().getPreviewThemeManager())
        .environment(\.managedObjectContext, context)
}
