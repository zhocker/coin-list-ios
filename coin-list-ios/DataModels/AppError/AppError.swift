//
//  AppError.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import Foundation

struct AppError {
    
    let message: String

    init(message: String) {
        self.message = message
    }
    
}

extension AppError: LocalizedError {
    
    var errorDescription: String? { return message }
    
}
