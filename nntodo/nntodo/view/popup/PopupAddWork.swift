//
//  PopupAddWork.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/19/25.
//

import SwiftUI

struct PopupAddWork: View {
    
    private let PLACEHOLDER: String = "여기에 새 작업을 입력하세요."
    @EnvironmentObject var theme: ThemeManager
    @State private var nameWork: String = ""
    
    var body: some View {
        VStack {
            TextEditerNn(placeholder: PLACEHOLDER, text: $nameWork)
            
            HStack {
                Button {
                    // 카테고리 목록 열기
                } label: {
                    Text("카테고리 없음")
                        .font(.system(size: 12))
                        .foregroundStyle(theme.foregroundWeek)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(theme.bgArea)
                .cornerRadius(15)
                
                Button {
                    // 카테고리 목록 열기
                } label: {
                    Text("달력")
                        .font(.system(size: 12))
                        .foregroundStyle(theme.foreground)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .cornerRadius(15)
                
                Button {
                    // 카테고리 목록 열기
                } label: {
                    Text("하위 작업 추가")
                        .font(.system(size: 12))
                        .foregroundStyle(theme.foreground)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .cornerRadius(15)
                
                Button {
                    // 카테고리 목록 열기
                } label: {
                    Text("템플릿으로 추가")
                        .font(.system(size: 12))
                        .foregroundStyle(theme.foreground)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .cornerRadius(15)
                
                Spacer()
                
                Button {
                    // 카테고리 목록 열기
                } label: {
                    Text("작업 추가")
                        .font(.system(size: 12))
                        .foregroundStyle(theme.foreground)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(theme.btnBgArea)
                .cornerRadius(15)
            }
        }
        .padding(20)
        .background(theme.background)
    }
}

#Preview {
    PopupAddWork()
        .environmentObject(ThemeManager())
}
