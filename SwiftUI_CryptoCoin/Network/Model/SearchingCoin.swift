//
//  SearchingCoin.swift
//  SwiftUI_CryptoCoin
//
//  Created by 강석호 on 9/7/24.
//

import Foundation

struct SearchingCoin: Hashable, Identifiable, Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
}

struct SearchingCoinsResponse: Decodable {
    let coins: [SearchingCoin]
}
