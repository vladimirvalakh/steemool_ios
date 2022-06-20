//
//  CGFloat.swift
//  ProgrammaticLayout
//
//  Created by Родион on 01.12.2020.
//  Copyright © 2020 Rodion Artyukhin. All rights reserved.
//

import UIKit

extension CGFloat {
    var adaptedFontSize: CGFloat {
        adapted(dimensionSize: self, to: .width)
    }
}
