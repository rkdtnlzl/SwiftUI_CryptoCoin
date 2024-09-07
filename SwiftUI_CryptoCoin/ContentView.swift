//
//  ContentView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var favoriteCoins: [SearchingCoin] = []
    
    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            SearchingView(favoriteCoins: $favoriteCoins)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            FavoriteView(favoriteCoins: favoriteCoins)
                .tabItem {
                    Image(systemName: "folder")
                }
        }
    }
}

#Preview {
    ContentView()
}
