//
//  MainCoordinatorOutput.swift
//  Steemool
//
//  Created by Екатерина Неделько on 21.06.22.
//

import Foundation

protocol MainCoordinatorOutput: AnyObject {
    var finishFlow: EmptyClosure? { get set }
}
