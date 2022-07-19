//
//  UIView+Extensions.swift
//  Steemool
//
//  Created by Екатерина Неделько on 27.06.22.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        if let firstIndex = self.layer.sublayers?.firstIndex(where: {$0.name == "gradient" }) {
            return
        }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.name = "gradient"
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }

        gradient.position = self.center
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func removeGradient() {
        if let firstIndex = self.layer.sublayers?.firstIndex(where: {$0.name == "gradient" }) {
            self.layer.sublayers?.remove(at: firstIndex)
        }
    }
}
