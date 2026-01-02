//
//  ItmeSubwork.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/23/25.
//

import SwiftUI
import CoreData

struct ItemSubwork: View {
    // init
    private let id: UUID
    private let onDelete: () -> Void
    init(_ id: UUID, onDelete: @escaping () -> Void) {
        self.id = id
        self.onDelete = onDelete
    }
    // constant
    private let placeholder: String = "Input a new name of this subwork."
    // environment
    @EnvironmentObject var theme: ThemeManager
    @Environment(\.managedObjectContext) private var viewContext
    // state
    @State var subwork: Subwork? = nil

    var body: some View {
        Group {
            if let subwork = self.subwork {
                HStack {
                    Button {
                        subwork.is_completed.toggle()
                        PersistenceController.shared.save(viewContext)
                    } label: {
                        Text("img")
                            .frame(width: 20, height: 20)
                            .padding(5)
                            .foregroundStyle(!subwork.is_completed ? theme.foreground : theme.foregroundReversal)
                            .background(!subwork.is_completed ? theme.btnBgDeactived : theme.btnBgActived)
                            .cornerRadius(10)
                    }
                    
                    TextEditerSubwork(
                        placeholder: placeholder,
                        text: Binding<String>(get: {
                                subwork.name
                            }, set: { new in
                                subwork.name = new
                                PersistenceController.shared.save(viewContext)
                            }),
                        isChecked: Binding<Bool>(get: {
                            subwork.is_completed
                        }, set: { new in
                            
                        }))
                    
                    Spacer()
                    
                    Button {
                        onDelete()
                    } label: {
                        Text("X")
                            .frame(width: 10, height: 10)
                            .padding(5)
                            .foregroundStyle(theme.foregroundWeek)
                            .cornerRadius(15)
                    }
                }
                .frame(height: 20)
                .padding(.vertical, 10)
                .cornerRadius(10)
            } else {
                HStack {
                    Spacer()
                    Text("해당 subwork를 찾을 수 없습니다.")
                    Spacer()
                }
                .frame(height: 20)
                .padding(.vertical, 10)
                .cornerRadius(10)
                .background(theme.bgArea)
            }
        }
        .onAppear() {
            subwork = fetchSubwork(id: id, context: viewContext)
        }
    }
    
    func fetchSubwork(id: UUID, context: NSManagedObjectContext) -> Subwork? {
        let request: NSFetchRequest<Subwork> = Subwork.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1

        return try? context.fetch(request).first
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    var data: Subwork {
        let testWork = Work.createNew(context)
        let testSubwork = Subwork.createNew(context, work: testWork, sortNum: "0")
        return testSubwork
    }
    
    ItemSubwork(data.id) {
        print("Todo's detail page was opened.")
    }
    .environmentObject(ThemeManager().getPreviewThemeManager())
    .environment(\.managedObjectContext, context)
    ItemSubwork(data.id) {
        print("Todo's detail page was opened.")
    }
    .environmentObject(ThemeManager().getPreviewThemeManager())
    .environment(\.managedObjectContext, context)
    ItemSubwork(UUID()) {
        print("Todo's detail page was opened.")
    }
    .environmentObject(ThemeManager().getPreviewThemeManager())
    .environment(\.managedObjectContext, context)
}
