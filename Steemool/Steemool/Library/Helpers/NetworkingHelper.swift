//
//  NetworkingHelper.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 7.08.22.
//

import Foundation

struct Link {
    let scheme: String
    let host: String
    let path: String
    let id: String?
    
    init(host: String = ProcessInfo.processInfo.environment["api_host"]!,
         scheme: String = "http",
         path: String,
         id: String? = nil
    ) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.id = id
    }
}

class NetworkingHelper {
    static func buildURL(from link: Link) -> URL? {
        var components = URLComponents()
        components.scheme = link.scheme
        components.host = link.host
        components.path = link.path
        if let id = link.id { components.path += "/\(id)" }
        return components.url
    }
}
