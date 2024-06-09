//
//  UIView+Animation.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import Foundation
import UIKit

extension UIView {
    
    func startRotating(duration: CFTimeInterval = 1.0) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = CGFloat.pi * 2.0
        rotation.duration = duration
        rotation.repeatCount = Float.infinity
        layer.add(rotation, forKey: "rotationAnimation")
    }

    func stopRotating() {
        layer.removeAnimation(forKey: "rotationAnimation")
    }
    
}
