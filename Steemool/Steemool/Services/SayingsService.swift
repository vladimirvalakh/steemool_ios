//
//  SayingsService.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 17.06.22.
//

import Foundation

private struct SayingResponse: Decodable {
    let status: String
    let data: Saying
}

private struct SayingsResponse: Decodable {
    let status: String
    let data: [Saying]
}

protocol SayingsServiceProtocol {
    func getAllSayings(completion: @escaping ([Saying]?, Error?) -> ())
    func getRandomSaying(completion: @escaping (Saying?, Error?) -> ())
    func getSaying(with id: String, completion: @escaping (Saying?, Error?) -> ())
}

class SayingsService {
    
    //links
    private let allSayingsLink = Link(path: "/api/v1/sayings")
    private let randomSayingLink = Link(path: "/api/v1/saying/random")
    
    private func sayingLink(with id: String) -> Link {
        Link(path: "/api/v1/saying", id: id)
    }
    
    private func fetchData(from link: Link, completion: @escaping (Data?, Error?) -> ()) {

        guard let url = NetworkingHelper.buildURL(from: link) else {
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
        
        fetchData(from: allSayingsLink) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let sayingsResponse = try decoder.decode(SayingsResponse.self, from: data)
                completion(sayingsResponse.data, nil)
            }
            catch let error {
                completion(nil, error)
            }
        }
    }
    
    func getRandomSaying(completion: @escaping (Saying?, Error?) -> ()) {
        
        fetchData(from: randomSayingLink) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let sayingResponse = try decoder.decode(SayingResponse.self, from: data)
                completion(sayingResponse.data, nil)
            }
            catch let error {
                completion(nil, error)
            }
        }
    }
    
    func getSaying(with id: String, completion: @escaping (Saying?, Error?) -> ()) {
        
        fetchData(from: sayingLink(with: id)) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let sayingResponse = try decoder.decode(SayingResponse.self, from: data)
                completion(sayingResponse.data, nil)
            }
            catch let error {
                completion(nil, error)
            }
        }
    }
}
