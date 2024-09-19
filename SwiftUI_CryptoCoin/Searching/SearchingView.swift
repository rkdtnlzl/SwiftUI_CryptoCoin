//
//  SearchingView.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/6/24.
//

import SwiftUI
import Alamofire
import Kingfisher

struct SearchingView: View {
    
    @State private var searchText = ""
    @State private var searchingCoins: [SearchingCoin] = []
    
    @Binding var favoriteCoins: [SearchingCoin]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                listView()
            }
            .navigationBarTitle("검색기능")
            .navigationBarItems(trailing: ProfileButton())
            .onAppear {
                fetchSearchingCoins()
            }
        }
    }
    
    func listView() -> some View {
        List {
            let exactMatchCoins = binarySearchCoins(query: searchText)
            let filteredCoins = searchingCoins.filter { coin in
                searchText.isEmpty || coin.name.lowercased().contains(searchText.lowercased())
            }
            
            if !exactMatchCoins.isEmpty {
                ForEach(exactMatchCoins) { coin in
                    coinRowView(coin: coin)
                }
            }
            
            ForEach(filteredCoins) { coin in
                if !exactMatchCoins.contains(where: { $0.id == coin.id }) {
                    coinRowView(coin: coin)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    func coinRowView(coin: SearchingCoin) -> some View {
        HStack {
            KFImage(URL(string: "\(coin.thumb)")!)
                .resizable()
                .frame(width: 40, height: 40)
            Text(coin.name)
            Spacer()
            Button(action: {
                toggleFavorite(coin: coin)
            }, label: {
                Image(systemName: favoriteCoins.contains(where: { $0.id == coin.id }) ? "star.fill" : "star")
            })
        }
    }
    
    func toggleFavorite(coin: SearchingCoin) {
        if let index = favoriteCoins.firstIndex(where: { $0.id == coin.id }) {
            favoriteCoins.remove(at: index)
        } else {
            favoriteCoins.append(coin)
        }
    }
    
    func fetchSearchingCoins() {
        let url = APIUrl.searchingURL
        
        AF.request(url).responseDecodable(of: SearchingCoinsResponse.self) { response in
            switch response.result {
            case .success(let data):
                searchingCoins = data.coins.sorted { $0.name < $1.name }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func binarySearchCoins(query: String) -> [SearchingCoin] {
        if query.isEmpty { return [] }
        
        var left = 0
        var right = searchingCoins.count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            let midCoin = searchingCoins[mid]
            
            if midCoin.name.lowercased() == query.lowercased() {
                return [midCoin]
            } else if midCoin.name.lowercased() < query.lowercased() {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        
        return []
    }
}
