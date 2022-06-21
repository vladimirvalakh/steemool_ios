//
//  Presentable.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
