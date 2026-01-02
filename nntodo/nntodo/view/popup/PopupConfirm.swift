//
//  PopupConfirm.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/3/25.
//

import SwiftUI

struct PopupConfirm: View {
    let title: String
    var message: String? = nil
    var textBtnCancle: String? = nil
    var actionBtnCancle: (() -> Void)? = nil
    let textBtnOk: String
    var actionBtnOk: (() -> Void)? = nil
    @Binding var isPresented: Bool
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        ContainerPopup(isPresented: $isPresented) {
            VStack(alignment: .center, spacing: 0) {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let m = message {
                    Text(m)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(theme.foregroundWeek)
                        .padding(.top, 8)
                        .padding(.bottom, 30)
                }
                
                HStack(spacing: 15) {
                    Spacer()
                    
                    if let text = textBtnCancle {
                        Button {
                            if let action = actionBtnCancle {
                                action()
                            }
                            isPresented = false
                        } label: {
                            Text(text)
                                .foregroundStyle(theme.foreground)
                        }
                    }
                    
                    Button {
                        if let action = actionBtnOk {
                            action()
                        }
                        isPresented = false
                    } label: {
                        Text(textBtnOk)
                            .foregroundStyle(theme.foreground)
                    }
                }
            }
            .padding(20)
            .background(theme.background)
            .cornerRadius(10)
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    PopupConfirm(title: "title", message: "message", textBtnCancle: "cancle", textBtnOk: "ok", isPresented: $isPresented)
        .environmentObject(ThemeManager().getPreviewThemeManager())
    PopupConfirm(title: "title", message: nil, textBtnCancle: nil, textBtnOk: "ok", isPresented: $isPresented)
        .environmentObject(ThemeManager().getPreviewThemeManager())
}
