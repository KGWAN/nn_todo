//
//  WidthMeasurer.swift
//  nntodo
//
//  Created by JUNGGWAN KIM on 11/19/25.
//

import Foundation
import SwiftUICore

struct WidthMeasurer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: MaxWidthPreferenceKey.self,
                                    value: proxy.size.width)
                }
            )
    }
}
