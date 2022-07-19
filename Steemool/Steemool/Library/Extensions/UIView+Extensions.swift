//
//  UIView+Extensions.swift
//  Steemool
//
//  Created by Екатерина Неделько on 27.06.22.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }

        gradient.position = self.center
        self.layer.insertSublayer(gradient, at: 0)
    }
}
