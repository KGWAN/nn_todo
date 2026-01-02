//
//  PopupSideMenu.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/19/25.
//

import SwiftUI

struct PopupSideMenu: View {
    @EnvironmentObject var theme: ThemeManager
    private let listMenu: [String] = Dummy.listMenu
    private let listKategorie: [String] = Dummy.listKategorie
    @State var isOpenedKategorie: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("nn-To Do")
                .font(.title)
                .bold(true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 40)
                .padding(.bottom, 20)
                .background(theme.bgArea)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(listMenu, id: \.self) { i in
                        Button {
                            // menu
                            switch i {
                            case "Kategorie":
                                isOpenedKategorie.toggle()
                            default:
                                print("menu(\(i)) touched")
                            }
                        } label: {
                            HStack {
                                Text("img")
                                    .frame(width: 40, height: 40)
                                    .padding(5)
                                    .foregroundStyle(theme.foreground)
                                    .background(theme.bgArea)
                                    .cornerRadius(10)
                                Text(i)
                                    .foregroundStyle(theme.foreground)
                                Spacer()
                            }
                            .padding(.bottom, 5)
                        }
                        if (i.elementsEqual("Kategorie") && isOpenedKategorie) {
                            ForEach(listKategorie, id: \.self) { k in
                                Button {
                                    print("menu_kategorie(\(i)) touched")
                                } label: {
                                    HStack {
                                        Text("img")
                                            .frame(width: 40, height: 40)
                                            .padding(5)
                                            .foregroundStyle(theme.foreground)
                                            .background(theme.bgArea)
                                            .cornerRadius(10)
                                        Text(k)
                                            .foregroundStyle(theme.foreground)
                                        Spacer()
                                    }
                                    .padding(.bottom, 5)
                                    .padding(.leading, 15)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 25)
            }
        }
        .frame(minWidth: 280)
        .background(theme.background)
    }
}

#Preview {
    PopupSideMenu()
        .environmentObject(ThemeManager())
}
