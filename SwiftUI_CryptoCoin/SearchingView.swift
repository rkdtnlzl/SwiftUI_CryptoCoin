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
                }
            }
        }
        .listStyle(PlainListStyle())
        .onTapGesture {
            hideKeyboard()
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

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search Coin", text: $text)
                    .foregroundColor(.primary)
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

#Preview {
    
    SearchingView()
}
