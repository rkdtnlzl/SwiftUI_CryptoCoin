//
//  MyFavoriteScrollView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/9/24.
//

import SwiftUI

struct MyFavoriteScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<5) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 200, height: 150)
                        .overlay(
                            Text("Item")
                                .foregroundColor(.black)
                                .font(.headline)
                        )
                }
            }
            .padding(.leading, 16)
            .padding(.top, 10)
        }
    }
}
#Preview {
    MyFavoriteScrollView()
}
