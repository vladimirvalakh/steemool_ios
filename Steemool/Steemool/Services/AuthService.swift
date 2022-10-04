//
//  AuthService.swift
//  Steemool
//
//  Created by Evgeniy Petlitskiy on 7.08.22.
//

import Foundation

fileprivate struct RegistrationData: Codable {
    let name: String
    let email: String
    let password: String
}

fileprivate struct AuthData: Codable {
    let email: String
    let password: String
}

fileprivate struct AuthResponse: Codable {
    let status: String
    let data: AuthDataResponse
}

fileprivate struct AuthDataResponse: Codable {
    let token: String
    let accessTokenExpiresIn: Int
    let refreshTokenExpiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case token
        case accessTokenExpiresIn = "access_token_expires_in"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
    }
}

class AuthService {
    
    private let registerLink = Link(path: "/api/v1/user/register")
    private let authLink = Link(path: "/api/v1/user/auth")
    private let refreshTokenLink = Link(path: "/api/v1/user/refresh")
    
    private let accessTokenKey = "accessToken"
    private var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    private let refreshTokenKey = "refreshTokenExpiresIn"
    private var refreshTokenExpirationDate: Double {
        get {
            UserDefaults.standard.double(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: refreshTokenKey)
        }
    }
}

//MARK: - API

extension AuthService {
    
    func registerUser(with name: String, email: String, password: String, completion: @escaping (String?, Error?) -> ()) {
        
        //convert method data to Data type
        var jsonData = Data()
        do {
            let userData = RegistrationData(name: name, email: email, password: password)
            jsonData = try JSONSerialization.data(withJSONObject: userData)
        } catch let error {
            completion(nil, error)
            return
        }
        
        //getting url
        guard let url = NetworkingHelper.buildURL(from: registerLink) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }
        
        //request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: String] {
                guard let status = responseJSON["status"] else { return }
                completion(status, nil)
            }
        }
        
        task.resume()
    }
    
    func authUser(with email: String, password: String, completion: @escaping (String?, Error?) -> ()) {
        
        //convert method data to Data type
        var jsonData = Data()
        do {
            let userData = AuthData(email: email, password: password)
            jsonData = try JSONSerialization.data(withJSONObject: userData)
        } catch let error {
            completion(nil, error)
            return
        }
        
        //getting url
        guard let url = NetworkingHelper.buildURL(from: authLink) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }
        
        //request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            let responseData = try? decoder.decode(AuthResponse.self, from: data)
            self.accessToken = responseData?.data.token
            self.refreshTokenExpirationDate = Date().timeIntervalSinceReferenceDate + Double(responseData!.data.refreshTokenExpiresIn)
            completion(responseData?.status, nil)
        }
        
        task.resume()
    }
    
    func refreshToken(completion: @escaping (String?, Error?) -> ()) {
        
        //getting url
        guard let url = NetworkingHelper.buildURL(from: refreshTokenLink) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }
        
        //request
        var request = URLRequest(url: url)
        let tokenHeaderField = "Authorization"
        if let accessToken { request.addValue(accessToken, forHTTPHeaderField: tokenHeaderField) }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, let response = response as? HTTPURLResponse, error == nil else {
                completion(nil, error)
                return
            }
            
            let token = response.allHeaderFields[tokenHeaderField] as? String
            self.accessToken = token
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: String] {
                guard let status = responseJSON["status"] else { return }
                completion(status, nil)
            }
        }
        
        task.resume()
    }
}
