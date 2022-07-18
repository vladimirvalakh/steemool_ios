//
//  UIApplication+Extensions.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import Foundation
import UIKit

extension UIApplication {
    static func topViewController(_ controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }
        return controller
    }
}
