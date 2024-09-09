//
//  TrendingView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/5/24.
//

import SwiftUI
import Alamofire
import Kingfisher

struct TrendingView: View {
    
    @State private var trendingCoins: [TrendingCoin] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("My Favorite")
                        .bold()
                        .font(.title2)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    Spacer()
                }
                MyFavoriteScrollView()
                HStack {
                    Text("Top 15 Coin")
                        .bold()
                        .font(.title2)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    Spacer()
                }
                TopCoinScrollView(trendingCoins: trendingCoins)
                Spacer()
            }
            .onAppear {
                fetchTrendingCoins()
            }
            .navigationTitle("Crypto Coin")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ProfileButton()
                }
            }
        }
        
    }
    
    func fetchTrendingCoins() {
        let url = APIUrl.trendingURL
        
        AF.request(url).responseDecodable(of: TrendingCoinsResponse.self) { response in
            switch response.result {
            case .success(let data):
                let sortedCoins = data.coins.map { $0.item }
                    .sorted(by: { $0.marketCapRank < $1.marketCapRank })
                trendingCoins = Array(sortedCoins.prefix(15))
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    TrendingView()
}
