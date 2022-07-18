//
//  MainCoordinator.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import Foundation
import UIKit

class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    // MARK: - Internal Properties
    
    var finishFlow: EmptyClosure?

    // MARK: - Private Properties
    
    private let router: Router

    // MARK: - Initialization
    
    init(router: Router) {
        self.router = router
    }

    // MARK: - BaseCoordinator
    
    override func start() {
        super.start()
        showMain()
    }
}

// MARK: - Private Methods

private extension MainCoordinator {
    func showMain() {
        let (view) = MainModuleConfigurator().configure()
        router.setRootModule(UINavigationController(rootViewController: view))
    }
}
