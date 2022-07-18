//
//  Device.swift
//  ProgrammaticLayout
//
//  Created by Родион on 30.11.2020.
//  Copyright © 2020 Rodion Artyukhin. All rights reserved.
//

import UIKit

enum Device {
    case iPhone5S
    case iPhone8
    case iPhone8Plus
    case iPhone11Pro
    case iPhone11ProMax
    case iPhone12
    case iPhone12ProMax
    
    static let baseScreenSize: Device = .iPhone12
}

extension Device: RawRepresentable {
    typealias RawValue = CGSize
    
    init?(rawValue: CGSize) {
        switch rawValue {
        case CGSize(width: 320, height: 568):
            self = .iPhone5S
        case CGSize(width: 375, height: 667):
            self = .iPhone8
        case CGSize(width: 414, height: 736):
            self = .iPhone8Plus
        case CGSize(width: 375, height: 812):
            self = .iPhone11Pro
        case CGSize(width: 414, height: 896):
            self = .iPhone11ProMax
        case CGSize(width: 390, height: 844):
            self = .iPhone12
        case CGSize(width: 428, height: 926):
            self = .iPhone12ProMax
        default:
            return nil
        }
    }
    
    var rawValue: CGSize {
        switch self {
        case .iPhone5S:
            return CGSize(width: 320, height: 568)
        case .iPhone8:
            return CGSize(width: 375, height: 667)
        case .iPhone8Plus:
            return CGSize(width: 414, height: 736)
        case .iPhone11Pro:
            return CGSize(width: 375, height: 812)
        case .iPhone11ProMax:
            return CGSize(width: 414, height: 896)
        case .iPhone12:
            return CGSize(width: 390, height: 844)
        case .iPhone12ProMax:
            return CGSize(width: 428, height: 926)
        }
    }
}
