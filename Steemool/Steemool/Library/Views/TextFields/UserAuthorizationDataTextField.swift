//
//  UserAuthorizationDataTextField.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class UserAuthorizationDataTextField: UITextField {

    // MARK: - Initialisation
    
    init() {
        super.init(frame: .zero)
        
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance Methods

private extension UserAuthorizationDataTextField {
    func setupAppearance() {
        self.frame = CGRect(x: 0, y: 0, width: 358, height: 52)
        self.clipsToBounds = true
        self.layer.cornerRadius = 13.HAdapted
        self.backgroundColor = .white
        self.tintColor = .lightGray
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 9.HAdapted, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
