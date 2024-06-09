//
//  CoinViewModelFormatter.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import Foundation

class CoinViewModelFormatter {
        
    private let priceFormatter: NumberFormatter
    private let marketCapFormatter: NumberFormatter

    init() {
        self.priceFormatter = NumberFormatter()
        self.priceFormatter.numberStyle = .currency
        self.priceFormatter.currencySymbol = "$"
        self.priceFormatter.maximumFractionDigits = 2
        self.priceFormatter.minimumFractionDigits = 2
        
        self.marketCapFormatter = NumberFormatter()
        self.marketCapFormatter.numberStyle = .currency
        self.marketCapFormatter.currencySymbol = "$"
        self.marketCapFormatter.maximumFractionDigits = 0
    }

    func formatPrice(price: Double) -> String {
        return priceFormatter.string(from: NSNumber(value: price)) ?? "$0.00"
    }

    func formatMarketCap(marketCap: Double) -> String {
        return marketCapFormatter.string(from: NSNumber(value: marketCap)) ?? "$0"
    }
    
    func determineChangeColorAndIcon(change: String?) -> (changeColor: String, changeIcon: String) {
        guard let change = change else {
            return ("#000000", "")
        }
        
        if change.contains("-") {
            return ("#F82D2D", "icon-arrow-down")
        } else if change == "0.00" {
            return ("#000000", "")
        } else {
            return ("#13BC24", "icon-arrow-up")
        }
    }
    
    func formatPrice(from coin: Coin) -> String {
        if let price = Double(coin.price ?? "") {
            return formatPrice(price: price)
        }
        
        return "$0.00"
    }
}
