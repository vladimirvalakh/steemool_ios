//
//  BaseCoordinator.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import Foundation

class BaseCoordinator: Coordinatable {

    // MARK: - Public Properties
    
    var childCoordinators: [Coordinatable] = []

    // MARK: - Internal Methods
    
    func start() {
        start(with: nil)
    }

    func start(with deepLinkOption: DeepLinkOption?) { }

    func addDependency(_ coordinator: Coordinatable) {
        guard !haveDependency(coordinator) else {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinatable?) {
        guard
            !childCoordinators.isEmpty,
            let coordinator = coordinator
            else { return }

        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    // MARK: - Private Methods
    
    private func haveDependency(_ coordinator: Coordinatable) -> Bool {
        for element in childCoordinators {
            if element === coordinator {
                return true
            }
        }
        return false
    }
}
