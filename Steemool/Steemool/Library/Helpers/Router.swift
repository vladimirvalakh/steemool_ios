//
//  Router.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import UIKit

class Router: Routable {
    private var window: UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }

    private var navigationController: UINavigationController? {
        if let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController {
            return tabBar.selectedViewController as? UINavigationController
        }
        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
    }

    private var tabBarController: UITabBarController? {
        return UIApplication.shared.windows.first?.rootViewController as? UITabBarController
    }

    private var topViewController: UIViewController? {
        return UIApplication.topViewController()
    }

    func present(_ module: Presentable?) {
        self.present(module, animated: true, completion: nil)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        if let controller = module?.toPresent() {
            self.topViewController?.present(controller, animated: animated)
        }
    }

    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        if let controller = module?.toPresent() {
            self.topViewController?.present(controller, animated: animated, completion: completion)
        }
    }

    func push(_ module: Presentable?) {
        self.push(module, animated: true)
    }

    func push(_ module: Presentable?, animated: Bool) {
        if let controller = module?.toPresent() {
            self.topViewController?.navigationController?.pushViewController(controller, animated: animated)
        }
    }
    
    func popModule() {
        self.popModule(animated: true)
    }

    func popModule(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }

    func popPreviousView() {
        let navigationController = self.topViewController?.navigationController
        guard
            var controllers = navigationController?.viewControllers,
            controllers.count >= 3 else {
                return
        }
        controllers.remove(at: controllers.count - 2)
        navigationController?.viewControllers = controllers
    }

    func dismissModule() {
        self.dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        topViewController?.dismiss(animated: animated, completion: completion)
    }

    func setNavigationControllerRootModule(_ module: Presentable?, animated: Bool = false, hideBar: Bool = false) {
        if let controller = module?.toPresent() {
            navigationController?.isNavigationBarHidden = hideBar
            navigationController?.setViewControllers([controller], animated: false)
        }
    }

    func setRootModule(_ module: Presentable?) {
        window?.rootViewController = module?.toPresent()
    }
}
