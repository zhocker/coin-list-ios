//
//  UIImageView+SVG.swift
//  coin-list-ios
//
//  Created by User on 9/6/2567 BE.
//

import Foundation
import SwiftDraw

private let svgCache = NSCache<NSURL, UIImage>()

extension UIImageView {
    
    func loadSVG(from url: URL) {
        
        DispatchQueue.global(qos: .default).async {
            if let cachedSVG = svgCache.object(forKey: url as NSURL) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.image = cachedSVG
                }
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else {
                    return
                }
                DispatchQueue.global(qos: .default).async {
                    if let svgImage = UIImage(svgData: data) {
                        svgCache.setObject(svgImage, forKey: url as NSURL)
                        DispatchQueue.main.async {
                            self.image = svgImage
                        }
                    }
                }
            }.resume()
        }
        
    }
    
}
