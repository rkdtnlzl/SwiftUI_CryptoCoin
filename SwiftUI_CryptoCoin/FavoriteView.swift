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
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 160, height: 160)
                                        .foregroundColor(.white)
                                    .shadow(radius: 4, x: 0.7, y: 0.7)
                                    HStack {
                                        VStack {
                                            KFImage(URL(string: "\(coin.thumb)"))
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                            Spacer()
                                        }
                                        Text(coin.name)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Text(coin.symbol.uppercased())
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    .padding()
                                }
                                
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Favorite Coins")
            }
        }
}

#Preview {
    FavoriteView(favoriteCoins: [
        SearchingCoin(id: "아이디",
                      name: "이름",
                      symbol: "심볼",
                      thumb: "https://coin-images.coingecko.com/coins/images/1/thumb/bitcoin.png")
    ])
}
