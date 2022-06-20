//
//  Saying.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 17.06.22.
//

import Foundation

struct Saying: Codable {
    let id: Int
    let text: String
    let author: String
    let image: String
    let lang: String
}
