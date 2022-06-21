//
//  UserAutorizationDataTextField.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class UserAutorizationDataTextField: UITextField {

    init() {
        super.init(frame: .zero)
        
        self.frame = CGRect(x: 0, y: 0, width: 358, height: 52)
        self.clipsToBounds = true
        self.layer.cornerRadius = 13.HAdapted
        self.backgroundColor = .white
        self.tintColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

