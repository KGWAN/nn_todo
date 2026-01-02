//
//  PopupOther.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/19/25.
//

import SwiftUI

///
/// 작업 뷰의 기타 메뉴 팝업
///
struct PopupOther: View {
    
    let list: [TypeMenu]
    var onSelected: ((TypeMenu) -> Void)
    
    @State var isActive: Bool = false
//    @State private var maxWidthOtherItem: CGFloat = 0
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(list) { item in
                Button {
                    // 기타 기능
                    onSelected(item)
                } label: {
                    Group {
                        switch item.action {
                        case "switch":
                            Text(isActive ? item.name : item.otherText ?? "")
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .foregroundStyle(theme.foreground)
                        default :
                            Text(item.name)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .foregroundStyle(theme.foreground)
                        }
                    }
                    .background(theme.areaTestOrange)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .fixedSize(horizontal: true, vertical: false) // 가로 방향으로 내부 콘텐츠 중 가장 넓은 것에 맞춤
        .padding(.vertical, 5)
        .background(theme.background)
        .cornerRadius(5)
        .shadow(color: theme.shadow, radius: 5)
    }
}

#Preview {
    PopupOther(list: Dummy.listMenuOtherViewWork.compactMap {
        TypeMenu(dictionary: $0)
    }) {code in
        print("\(code) btn touched.")
    }
    .environmentObject(ThemeManager().getPreviewThemeManager())
}
