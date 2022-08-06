//
//  UIViewController+Extensions.swift
//  Steemool
//
//  Created by Ekaterina Nedelko on 6.08.22.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboardAction))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboardAction() {
        self.view.endEditing(true)
    }
}
