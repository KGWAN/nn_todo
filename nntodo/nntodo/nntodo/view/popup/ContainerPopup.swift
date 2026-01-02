//
//  BasePopup.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 12/3/25.
//

import Foundation
import SwiftUICore

struct ContainerPopup<Content: View>: View {
    @Binding var isPresented: Bool
    var opacity: Double = 0.4
    @ViewBuilder var content: Content

    
    var body: some View {
        ZStack {
            ViewDim(isShowingPopup: $isPresented, opacity: opacity)
            content
                .padding(.horizontal, 20)
        }
    }
}
