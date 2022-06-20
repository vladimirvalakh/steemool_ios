//
//  Int.swift
//  ProgrammaticLayout
//
//  Created by Родион on 30.11.2020.
//  Copyright © 2020 Rodion Artyukhin. All rights reserved.
//

import UIKit

extension Int {
    var VAdapted: CGFloat {
        adapted(dimensionSize: CGFloat(self), to: .height)
    }
    
    var HAdapted: CGFloat {
        adapted(dimensionSize: CGFloat(self), to: .width)
    }
}
