//
//  SayingsService.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 17.06.22.
//

import Foundation

private struct SayingResponse: Decodable {
    let status: String
    let saying: Saying
}

private struct SayingsResponse: Decodable {
    let status: String
    let sayings: [Saying]
}

fileprivate enum SayingsLink {
    case link(scheme: String, host: String, path: String, id: String? = nil)
    
    static let allSayingsLink = SayingsLink.link(scheme: SayingsService.scheme,
                                                 host: SayingsService.host,
                                                 path: "/api/v1/sayings")
    
    static let randomSayingLink = SayingsLink.link(scheme: SayingsService.scheme,
                                                  host: SayingsService.host,
                                                  path: "/api/v1/saying/random")
    
    static func sayingLink(with id: String) -> SayingsLink {
        .link(scheme: SayingsService.scheme, host: SayingsService.host, path: "/api/v1/saying", id: id)
    }
}

protocol SayingsServiceProtocol {
    func getAllSayings(completion: @escaping ([Saying]?, Error?) -> ())
    func getRandomSaying(completion: @escaping (Saying?, Error?) -> ())
    func getSaying(with id: String, completion: @escaping (Saying?, Error?) -> ())
}

class SayingsService {
    
    fileprivate static let scheme = "http"
    fileprivate static let host = ProcessInfo.processInfo.environment["api_host"]!
    
    private func buildURL(from link: SayingsLink) -> URL? {
        switch link {
        case .link(let scheme, let host, let path, let id):
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            if let id = id { components.path += "/\(id)" }
            return components.url
        }
    }
    
    private func fetchData(from link: SayingsLink, completion: @escaping (Data?, Error?) -> ()) {

        guard let url = buildURL(from: link) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let session = URLSession(configuration: .default)

        let dataTask = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
}

// MARK: - API

extension SayingsService: SayingsServiceProtocol {
    
    func getAllSayings(completion: @escaping ([Saying]?, Error?) -> ()) {
        
        fetchData(from: SayingsLink.allSayingsLink) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            guard let sayingsResponse = try? decoder.decode(SayingsResponse.self, from: data) else {
                completion(nil, error)
                return
            }
            
            completion(sayingsResponse.sayings, nil)
        }
    }
    
    func getRandomSaying(completion: @escaping (Saying?, Error?) -> ()) {
        
        fetchData(from: SayingsLink.randomSayingLink) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            guard let sayingResponse = try? decoder.decode(SayingResponse.self, from: data) else {
                completion(nil, error)
                return
            }
            
            completion(sayingResponse.saying, nil)
        }
    }
    
    func getSaying(with id: String, completion: @escaping (Saying?, Error?) -> ()) {
        
        fetchData(from: SayingsLink.sayingLink(with: id)) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            guard let sayingResponse = try? decoder.decode(SayingResponse.self, from: data) else {
                completion(nil, error)
                return
            }
            
            completion(sayingResponse.saying, nil)
        }
    }
}
