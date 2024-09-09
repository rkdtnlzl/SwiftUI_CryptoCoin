//
//  ProfileButton.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/9/24.
//

import SwiftUI

struct ProfileButton: View {
    var body: some View {
        Button(action: {
            print("프로필 버튼 클릭됨")
        }, label: {
            Image(systemName: "person")
                .font(.system(size: 20))
                .padding(.all, 5)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                )
            
        })
    }
}

#Preview {
    ProfileButton()
}
