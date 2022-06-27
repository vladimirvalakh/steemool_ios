//
//  UIView+Extensions.swift
//  Steemool
//
//  Created by Екатерина Неделько on 27.06.22.
//

import UIKit

extension UIView {
    func applyGradient(colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(red: 0.975, green: 0.562, blue: 1, alpha: 1).cgColor,
                           UIColor(red: 0.831, green: 0.35, blue: 1, alpha: 1).cgColor]

        gradient.position = self.center
        self.layer.insertSublayer(gradient, at: 0)
    }
}
