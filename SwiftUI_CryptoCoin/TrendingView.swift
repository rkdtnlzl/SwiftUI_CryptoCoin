//
//  TrendingView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/5/24.
//

import SwiftUI

struct TrendingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProfileButton()
                .padding(.trailing, 16)
        }
        HStack {
            Text("Crypo Coin")
                .bold()
                .font(.largeTitle)
                .padding(.leading, 16)
            Spacer()
        }
        HStack {
            Text("My Favorite")
                .bold()
                .font(.title2)
                .padding(.leading, 16)
                .padding(.top, 16)
            Spacer()
        }
    }
}

struct ProfileButton: View {
    var body: some View {
        Button(action: {
            print("프로필 버튼 클릭됨")
        }, label: {
            Image(systemName: "person")
                .font(.system(size: 25))
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
    TrendingView()
}
