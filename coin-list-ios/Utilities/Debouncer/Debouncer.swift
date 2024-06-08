//
//  Debouncer.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import Foundation

class Debouncer {
    private var timer: Timer?
    private var interval: TimeInterval

    init(interval: TimeInterval) {
        self.interval = interval
    }

    func execute(action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            action()
        }
    }

    deinit {
        timer?.invalidate()
    }
}
