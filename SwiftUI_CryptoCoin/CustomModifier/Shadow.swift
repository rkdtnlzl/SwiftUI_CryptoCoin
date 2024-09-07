//
//  Shadow.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/7/24.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}

extension View {
    func customShadow(
        color: Color = Color(.sRGBLinear, white: 0, opacity: 0.33),
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat = 0
    ) -> some View {
        self.modifier(ShadowModifier(color: color, radius: radius, x: x, y: y))
    }
}
