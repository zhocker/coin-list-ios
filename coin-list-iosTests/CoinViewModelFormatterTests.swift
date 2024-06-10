//
//  CoinViewModelFormatterTests.swift
//  coin-list-iosTests
//
//  Created by User on 9/6/2567 BE.
//

import XCTest
@testable import coin_list_ios

final class CoinViewModelFormatterTests: XCTestCase {
    
    var formatter: CoinViewModelFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CoinViewModelFormatter()
    }
    
    override func tearDown() {
        formatter = nil
        super.tearDown()
    }
    
    func testFormatPrice() {
        XCTAssertEqual(formatter.formatPrice(price: 1234.56), "$1,234.56")
        XCTAssertEqual(formatter.formatPrice(price: 0.0), "$0.00")
    }
    
    func testFormatMarketCap() {
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 1_500_000_000_000), "$1.50 trillion")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 2_500_000_000), "$2.50 billion")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 3_500_000), "$3.50 million")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 45_000), "$45.00 thousand")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 10_000), "$10.00 thousand")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 9_900), "$9,900.00")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 1_234.56), "$1,234.56")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 900.56), "$900.56")
        XCTAssertEqual(formatter.formatMarketCap(marketCap: 0.0), "$0.00")
    }
    
    func testDetermineChangeColorAndIcon() {
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: "-1.23").changeColor, HexConstant.ciRed)
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: "-1.23").changeIcon, "icon-arrow-down")
        
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: "1.23").changeColor, HexConstant.ciGreen)
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: "1.23").changeIcon, "icon-arrow-up")
        
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: "0.00").changeColor, HexConstant.black)
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: "0.00").changeIcon, "")
        
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: nil).changeColor, HexConstant.black)
        XCTAssertEqual(formatter.determineChangeColorAndIcon(change: nil).changeIcon, "")
    }
    
    func testFormatPriceFromCoin() {
        let coin = Coin(uuid: nil, symbol: nil, name: nil, color: nil, iconUrl: nil, price: "1234.56", tier: nil, change: nil, rank: nil)
        XCTAssertEqual(formatter.formatPrice(from: coin), "$1,234.56")

        let emptyPriceCoin = Coin(uuid: nil, symbol: nil, name: nil, color: nil, iconUrl: nil, price: nil, tier: nil, change: nil, rank: nil)
        XCTAssertEqual(formatter.formatPrice(from: emptyPriceCoin), "$0.00")
    }
    
    func testFormatPriceFromCoinDetail() {
        let coinDetail = CoinDetail(uuid: nil, name: nil, symbol: nil, iconUrl: nil, price: "1234.56", description: nil, marketCap: nil, websiteUrl: nil, color: nil)
        XCTAssertEqual(formatter.formatPrice(from: coinDetail), "$1,234.56")

        let emptyPriceCoinDetail = CoinDetail(uuid: nil, name: nil, symbol: nil, iconUrl: nil, price: nil, description: nil, marketCap: nil, websiteUrl: nil, color: nil)
        XCTAssertEqual(formatter.formatPrice(from: emptyPriceCoinDetail), "$0.00")
    }
    
    func testFormatMarketCapFromCoinDetail() {
        let coinDetail = CoinDetail(uuid: nil, name: nil, symbol: nil, iconUrl: nil, price: nil, description: nil, marketCap: "1234567890", websiteUrl: nil, color: nil)
        XCTAssertEqual(formatter.formatMarketCap(from: coinDetail), "$1.23 billion")
        
        let emptyMarketCapCoinDetail = CoinDetail(uuid: nil, name: nil, symbol: nil, iconUrl: nil, price: nil, description: nil, marketCap: nil, websiteUrl: nil, color: nil)
        XCTAssertEqual(formatter.formatMarketCap(from: emptyMarketCapCoinDetail), "$0")
    }
}
