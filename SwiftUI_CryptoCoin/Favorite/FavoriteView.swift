//
//  FavoriteView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/7/24.
//

import SwiftUI
import Kingfisher

struct FavoriteView: View {
    
    let favoriteCoins: [SearchingCoin]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(favoriteCoins, id: \.id) { coin in
                        FavoriteCardView(coin: coin)
                    }
                }
                .padding()
            }
            .navigationTitle("Favorite Coins")
        }
    }
}

struct FavoriteCardView: View {
    
    let coin: SearchingCoin
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 160, height: 160)
                .foregroundColor(.white)
                .shadow(radius: 4, x: 0.7, y: 0.7)
            VStack {
                HStack {
                    KFImage(URL(string: "\(coin.thumb)"))
                        .resizable()
                        .frame(width: 40, height: 40)
                    VStack {
                        Text(coin.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(coin.symbol.uppercased())
                            .padding(.trailing)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                HStack {
                    Spacer()
                    Text("$ 100,000,000")
                        .bold()
                        .padding()
                }
            }
        }
    }
}

#Preview {
    FavoriteView(favoriteCoins: [
        SearchingCoin(id: "아이디",
                      name: "BitCoin",
                      symbol: "BTC",
                      thumb: "https://coin-images.coingecko.com/coins/images/1/thumb/bitcoin.png")
    ])
}
