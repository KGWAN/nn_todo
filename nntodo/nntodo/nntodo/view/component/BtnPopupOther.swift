import SwiftUI

///
/// 사용하는 부모뷰에 .zIndex를 줘야한다.
///
struct BtnPopupOther<Content: View, Content2: View>: View {
    // init
    let labelBtn: Content
    let content: Content2
    
    init(@ViewBuilder labelBtn: () -> Content,
         @ViewBuilder content: () -> Content2){
        self.labelBtn = labelBtn()
        self.content = content()
    }
    // state
    @State private var isShowingPopupOther: Bool = false
    @State private var buttonFrame: CGRect = .zero
    @State private var popupSize: CGSize = .zero // 팝업의 크기를 측정하기 위함
    // environment
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        ZStack {
            Button {
                isShowingPopupOther.toggle()
            } label: {
                labelBtn
                    .background(
                        GeometryReader { geometry in
                            theme.areaTestRed.onAppear {
                                buttonFrame = geometry.frame(in: .global)
                            }
                            .onChange(of: geometry.frame(in: .global)) { oldFrame, newFrame in
                                buttonFrame = newFrame
                            }
                        }
                    )
            }
            if isShowingPopupOther {
                content
                .background(
                    GeometryReader { proxy in
                        theme.areaTestOrange.onAppear {
                            popupSize = proxy.size
                        }
                        .onChange(of: proxy.size) { oldValue, newValue in
                            popupSize = newValue
                        }
                    }
                )
                .offset(
                    x: buttonFrame.width/2 - popupSize.width/2,
                    y: buttonFrame.height/2 + popupSize.height/2 + 10
                )
            }
        }
        .background(theme.areaTestYellow)
    }
}


#Preview {
    let listMenuOtherViewWork = Dummy.listMenuOtherViewKategorie.compactMap {
        TypeMenu(dictionary: $0)
    }
    let theme = ThemeManager().getPreviewThemeManager()
    
    BtnPopupOther {
        Text("img")
            .foregroundStyle(theme.foreground)
            .frame(width: 20, height: 20)
            .background(theme.areaTestBlue)
            .cornerRadius(10)
    } content: {
        PopupOther(list: listMenuOtherViewWork) { menu in
            
        }
    }
    .environmentObject(theme)
}
