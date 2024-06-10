//
//  UIView+Layer.swift
//  coin-list-ios
//
//  Created by User on 8/6/2567 BE.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let cgColor = layer.borderColor {
                return UIColor(cgColor: cgColor)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addBottomShadow(shadowColor: UIColor = .black, 
                         shadowOpacity: Float = 0.25,
                         shadowOffset: CGSize = CGSize(width: 0, height: 1),
                         shadowRadius: CGFloat = 1.5) {
        self.layer.shadowColor = shadowColor.cgColor
        
        self.layer.shadowOpacity = shadowOpacity
        
        self.layer.shadowOffset = shadowOffset
        
        self.layer.shadowRadius = shadowRadius
        
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: self.bounds.maxY - shadowRadius, width: self.bounds.width, height: shadowRadius))
        self.layer.shadowPath = shadowPath.cgPath
        
        self.layer.masksToBounds = false
        
    }
    
}
