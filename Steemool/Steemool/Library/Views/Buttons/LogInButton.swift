//
//  LogInButton.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class LogInButton: UIButton {
    
    // MARK: - Internal Properties
    
    private var status: LogInButtonStatus? {
        didSet {
            setupApearance()
        }
    }
    
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        
        setupApearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func makeActive() {
        status = .active
    }
    
    func makeInactive() {
        status = .inactive
    }
    
    // MARK: - Private Methods
    
    private func setupApearance() {
        self.frame = CGRect(x: 0, y: 0, width: 358.HAdapted, height: 52.VAdapted)
        self.clipsToBounds = true
        self.layer.cornerRadius = 13.HAdapted
        switch self.status {
        case .active:
            self.applyGradient(colors: [.customLightPink, .customPink])
            self.setTitleColor(.white, for: .normal)
            self.isEnabled = true
        case .inactive:
            self.removeGradient()
            self.backgroundColor = .customLightGray
            self.setTitleColor(.customGray, for: .normal)
            self.isEnabled = false
        default:
            self.removeGradient()
            self.backgroundColor = .white
            self.setTitleColor(.black, for: .normal)
            self.isEnabled = true
        }
    }
}

enum LogInButtonStatus {
    case active
    case inactive
}

