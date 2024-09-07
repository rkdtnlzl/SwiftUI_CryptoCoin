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
                    Spacer()
                    ProfileButton()
                        .padding(.trailing, 16)
                }
                HStack {
                    Text("Crypto Coin")
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
                FavoriteScrollView()
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
            .navigationTitle("Cry")
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

struct FavoriteScrollView: View {
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

struct TopCoinScrollView: View {
    
    let trendingCoins: [TrendingCoin]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(trendingCoins.chunked(into: 3), id: \.self) { chunk in
                    listView(coins: chunk)
                }
            }
            .padding(.leading, 16)
            .padding(.top, 10)
        }
    }
    
    func listView(coins: [TrendingCoin]) -> some View {
        LazyVStack(spacing: 10) {
            ForEach(coins) { coin in
                rowView(coin: coin)
                    .frame(height: 50)
                    .background(Color.white)
            }
        }
        .frame(width: 320)
    }
    
    func rowView(coin: TrendingCoin) -> some View {
        HStack {
            Text("\(coin.marketCapRank)")
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
    TrendingView()
}
