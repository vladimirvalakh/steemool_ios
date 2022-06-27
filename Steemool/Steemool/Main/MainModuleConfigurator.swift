//
//  MainModuleConfigurator.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import Foundation

final class MainModuleConfigurator {
    func configure() -> (SayingsViewController) {
        let view = SayingsViewController(nibName: nil, bundle: nil)
        
        return (view)
    }
}

