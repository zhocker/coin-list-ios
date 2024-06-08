//
//  CoinService.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation
import Moya


enum CoinService {
    case getCoins(limit: Int, offset: Int, keyword: String)
    case getCoinDetail(uuid: String)
}

extension CoinService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.coinranking.com/v2")!
    }
    
    var path: String {
        switch self {
        case .getCoins:
            return "/coins"
        case .getCoinDetail(let uuid):
            return "/coin/\(uuid)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCoins:
            return .get
        case .getCoinDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCoins(let limit, let offset, let keyword):
            return .requestParameters(
                parameters: ["limit": limit, "offset": offset, "search": keyword],
                encoding: URLEncoding.default
            )
        case .getCoinDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
