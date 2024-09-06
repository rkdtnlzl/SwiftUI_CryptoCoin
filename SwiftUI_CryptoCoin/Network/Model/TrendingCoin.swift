//
//  TrendingCoin.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/5/24.
//

import Foundation

struct TrendingCoin: Hashable, Identifiable, Decodable {
    let id: String
    let name: String
    let symbol: String
    let marketCapRank: Int
    let small: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, small
        case marketCapRank = "market_cap_rank"
    }
}

struct TrendingCoinsResponse: Decodable {
    let coins: [CoinWrapper]
    
    struct CoinWrapper: Decodable {
        let item: TrendingCoin
    }
}
