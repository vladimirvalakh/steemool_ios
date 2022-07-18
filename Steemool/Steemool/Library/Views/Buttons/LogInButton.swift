//
//  LogInButton.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class LogInButton: UIButton {
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupApearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupApearance() {
        self.frame = CGRect(x: 0, y: 0, width: 358.HAdapted, height: 52.VAdapted)
        self.clipsToBounds = true
        self.layer.cornerRadius = 13.HAdapted
        self.applyGradient(colours: [.yellow, .blue])
    }
}


