//
//  Collection+TakeSafe.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    func takeSafe(index : Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
}
