//
//  ContentView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var text = ""
    
    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            SearchingView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
    }
}

#Preview {
    ContentView()
}
