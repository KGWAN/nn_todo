import SwiftUI

///
/// 사용하는 부모뷰에 .zIndex를 줘야한다.
///
struct BtnPicker<C: View>: View {
    // init
    @Binding var isOpenedPopup: Bool
    let labelBtn: C
    
    init(_ toggleVar: Binding<Bool>,
        @ViewBuilder labelBtn: () -> C){
        self._isOpenedPopup = toggleVar
        self.labelBtn = labelBtn()
    }
    // state
    @State private var buttonFrame: CGRect = .zero
    @State private var popupSize: CGSize = .zero // 팝업의 크기를 측정하기 위함
    // environment
    @EnvironmentObject var theme: ThemeManager
    
    var body: some View {
        Button {
            isOpenedPopup.toggle()
            print("Was opened popup? : \(isOpenedPopup)")
        } label: {
            labelBtn
        }
        .anchorPreference(key: BoundPreferenceKey.self, value: .bounds) {
            $0
        }
    }
}


#Preview {
    @Previewable @State var isOpenedPopup: Bool = false
    let theme = ThemeManager().getPreviewThemeManager()
    
    BtnPicker($isOpenedPopup) {
        Text("img")
            .foregroundStyle(theme.foreground)
            .frame(width: 20, height: 20)
            .background(theme.areaTestBlue)
            .cornerRadius(10)
    }
    .environmentObject(theme)
}
