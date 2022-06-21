//
//  LogInButton.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class LogInButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupApearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupApearance() {
        self.frame = CGRect(x: 0, y: 0, width: 358, height: 52)
        self.clipsToBounds = true
        self.layer.cornerRadius = 13.HAdapted
        self.applyGradient(colours: [.yellow, .blue])
    }
    
}

private extension UIButton {
    func applyGradient(colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(red: 0.975, green: 0.562, blue: 1, alpha: 1).cgColor,
                           UIColor(red: 0.831, green: 0.35, blue: 1, alpha: 1).cgColor]

        gradient.position = self.center
        self.layer.insertSublayer(gradient, at: 0)
    }
}

