//
//  Array.swift
//  ProgrammaticLayout
//
//  Created by Родион on 01.12.2020.
//  Copyright © 2020 Rodion Artyukhin. All rights reserved.
//

import UIKit

extension Array where Element == Int {
    var VResized: CGSize {
        guard self.count == 2 else { fatalError("You have to specify 2 values: [width, height]") }
        return resized(size: CGSize(width: self[0], height: self[1]), basedOn: .height)
    }
    
    var HResized: CGSize {
        guard self.count == 2 else { fatalError("You have to specify 2 values: [width, height]") }
        return resized(size: CGSize(width: self[0], height: self[1]), basedOn: .width)
    }
}
