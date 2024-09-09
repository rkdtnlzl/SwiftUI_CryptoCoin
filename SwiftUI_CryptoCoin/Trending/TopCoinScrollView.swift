//
//  TopCoinScrollView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/9/24.
//

import SwiftUI
import Kingfisher

struct TopCoinScrollView: View {
    
    let trendingCoins: [TrendingCoin]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(trendingCoins.chunked(into: 3), id: \.self) { chunk in
                    VStack(spacing: 10) {
                        ForEach(Array(chunk.enumerated()), id: \.element) { index, coin in
                            rowView(coin: coin, rank: (trendingCoins.firstIndex(of: coin) ?? 0) + 1)
                                .frame(width: 300, height: 50)
                                .background(Color.white)
                        }
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.top, 10)
        }
    }
    
    func rowView(coin: TrendingCoin, rank: Int) -> some View {
        HStack {
            Text("\(rank)")
                .fontWeight(.bold)
            
            KFImage(URL(string: "\(coin.small)")!)
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
            VStack(alignment: .leading) {
                Text(coin.name)
                    .fontWeight(.bold)
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

#Preview {
    TopCoinScrollView(trendingCoins: [TrendingCoin(id: "aaa", name: "Bitcoin", symbol: "BTC", marketCapRank: 1, small: "star")])
}
