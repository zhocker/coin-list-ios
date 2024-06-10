//
//  Coin.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation

struct Coin: Codable {
    
    let uuid: String?
    let symbol: String?
    let name: String?
    let color: String?
    let iconUrl: String?
    let price: String?
    let tier: Int?
    let change: String?
    let rank: Int?
    
}
