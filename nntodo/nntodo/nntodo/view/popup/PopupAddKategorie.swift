//
//  PopupAddKategorie.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/26/25.
//

import SwiftUI

struct PopupAddKategorie: View {
    private let PLACEHOLDER: String = "Input a new kategorie's name."
    private let TITLE_ADD: String = "Create a new kategorie."
    private let TITLE_MODIFY: String = "Create a new kategorie(modify)."
    
    @Binding var isPresented: Bool
    @Binding var selectedKategorie: Kategorie?
    let mode: TypeMode
    
    @State var backup: Kategorie? = nil
    @State var name: String = ""
    @State var hexColor: String? = nil
    @State var isSettingColor: Bool = false
    let listColor: [String] = Dummy.listColorKategorie
    @EnvironmentObject var theme: ThemeManager
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        ContainerPopup(isPresented: $isPresented) {
            if let kategorie = selectedKategorie {
                VStack(alignment: .leading, spacing: 15) {
                    Text(mode == .MODIFY ? TITLE_MODIFY : TITLE_ADD)
                        .foregroundStyle(theme.foreground)
                    
                    TextEditerNn(placeholder: PLACEHOLDER, text: $name)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .onAppear {
                            name = kategorie.name
                        }
//                        .onChange(of: name) { oldValue, newValue in
//                            if oldValue != newValue {
//                                kategorie.name = newValue
//                            }
//                        }
                    
                    Button {
                        // 색상 선택 열기
                        isSettingColor.toggle()
                    } label: {
                        Text("카테고리 색상")
                            .foregroundStyle(theme.foreground)
                        Spacer()
                        Circle()
                            .fill(hexColor == nil ? theme.bgArea : Color(hex: hexColor!))
                            .frame(width: 15, height: 15)
                            .onAppear() {
                                hexColor = kategorie.color
                            }
                    }
                    
                    if isSettingColor {
                        HStack {
                            ForEach(listColor, id: \.self) { hex in
                                Circle()
                                    .fill(Color(hex: hex))
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
//                                        kategorie.color = hex
                                        hexColor = hex
                                    }
                            }
                            
                            Text("defalt")
                                .frame(width: 20, height: 20)
                                .foregroundStyle(theme.foreground)
                                .background(theme.bgArea)
                                .cornerRadius(10)
                                .onTapGesture {
                                    // 초기화
//                                    kategorie.color = nil
                                    hexColor = nil
                                }
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 5, content: {
                        Spacer()
                        
                        Button {
                            // insert
                            if mode == .CREATE {
                                // rollback
                                viewContext.delete(kategorie)
                                safeSave()
                            }
                            // dismiss
                            isPresented = false
                        } label: {
                            Text("취소")
                                .foregroundStyle(theme.foreground)
                                .padding(.vertical, 5)
                                .padding(.leading, 10)
                        }
                        
                        BtnSave(
                            action: {
                                // update data
                                kategorie.name = name
                                kategorie.color = hexColor
                                
                                // update or insert
                                if mode == .CREATE {
                                    // insert
                                    kategorie.generate_date = Date()
                                } else {
                                    // update
                                    kategorie.revised_date = Date()
                                }
                                // save
                                safeSave()
                                // dismiss
                                isPresented = false
                            },
                            isActive: Binding(
                                get: {
                                    !name.isEmpty
                                },
                                set: { _ in
                                }
                            )
                        )
                    })
                }
                .padding(20)
                .background(theme.background)
                .cornerRadius(15)
            }
        }
    }
    
    func safeSave() {
        // guard preview
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return
        }
        if let kategorie = selectedKategorie, !kategorie.canInsert() {
            return
        }
        // save
        PersistenceController.shared.save(viewContext)
    }
}

#Preview {
    @Previewable @State var isOpenedPopup: Bool = true
    @Previewable @State var data: Kategorie? = Kategorie.init(context: PersistenceController.preview.container.viewContext)
    
    PopupAddKategorie(
        isPresented: $isOpenedPopup,
        selectedKategorie: $data,
        mode: TypeMode.CREATE
    )
    .environmentObject(ThemeManager().getPreviewThemeManager())
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
