//
//  Coin.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import UIKit

struct Coin: Codable {
    
    let uuid: String?
    let symbol: String?
    let name: String?
    let color: String?
    let iconUrl: String?
    let marketCap: String?
    let price: String?
    let tier: Int?
    let change: String?
    let rank: Int?
    
}

extension Coin {
    
    var changeColor: String {
        guard let change = self.change else {
            return "#000000"
        }
        if change.contains("-") {
            return "#F82D2D"
        }
        if change == "0.00" {
            return "#000000"
        }
        return "#13BC24"
    }
    
    var changeIconImageName: String {
        guard let change = self.change else {
            return ""
        }
        if change.contains("-") {
            return "icon-arrow-down"
        }
        if change == "0.00" {
            return ""
        }
        return "icon-arrow-up"
    }
}
