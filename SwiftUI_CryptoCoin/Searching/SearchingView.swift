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
            ForEach(searchingCoins.filter { coin in
                searchText.isEmpty || coin.name.lowercased().contains(searchText.lowercased())
            }) { coin in
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
        }
        .listStyle(PlainListStyle())
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
                searchingCoins = data.coins
            case .failure(let error):
                print(error)
            }
        }
    }
}
