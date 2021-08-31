//
//  MovieDBAPI.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation

class MovieDBAPI {
    
    
    static func requestToken(completion: @escaping (Bool,Error?) -> Void) {
        guard  let url = movieDBURL.requestToken.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(false,error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let response = try jsonDecoder.decode(RequestTokenResponse.self, from: data)
                APIAuth.requestToken = response.requestToken
                completion(true,nil)
            }catch {
                do {
                    let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                    completion(false,errorResponse)
                }catch {
                    completion(false,error)
                }
            }
        }.resume()
    }
    
    static func login(with userName : String ,and password:String,completion:@escaping (Bool,Error?) -> Void) {
        guard  let url = movieDBURL.login.url else {
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let body = LoginRequest(username: userName, password: password, requestToken: APIAuth.requestToken)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(false,error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let response = try jsonDecoder.decode(RequestTokenResponse.self, from: data)
                    completion(true,nil)
                }catch {
                    do {
                        let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                        completion(false,errorResponse)
                    }catch {
                        completion(false,error)
                    }
                }
            }.resume()
        }catch {
            completion(false,error)
        }
    }
    
    
    
    static func createSessionID(completion: @escaping (Bool,Error?) -> Void) {
        guard  let url = movieDBURL.requestSession.url else {
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let body = CreateSessionRequest(requestToken: APIAuth.requestToken)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(false,error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let response = try jsonDecoder.decode(RequestSessionIDResponse.self, from: data)
                    APIAuth.sessionID  = response.sessionID
                    completion(true,nil)
                }catch {
                    do {
                        let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                        completion(false,errorResponse)
                    }catch {
                        completion(false,error)
                    }
                }
            }.resume()
        }catch {
            completion(false,error)
        }
    }
    
    
    static func requestGuestSession(completion: @escaping (Bool,Error?) -> Void) {
        guard  let url = movieDBURL.requestGuestSession.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(false,error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let response = try jsonDecoder.decode(RequestGuestSessionResponse.self, from: data)
                APIAuth.sessionID = response.guestSessionID
                completion(true,nil)
            }catch {
                do {
                    let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                    completion(false,errorResponse)
                }catch {
                    completion(false,error)
                }
            }
        }.resume()
    }
    
    
    static func deleteSessionID(completion: @escaping (Bool,Error?) -> Void) {
        guard  let url = movieDBURL.deleteSession.url else {
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let encoder = JSONEncoder()
            let body = LogoutRequest(sessionID: APIAuth.requestToken)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let _ = data else {
                    completion(false,error)
                    return
                }
                
                APIAuth.requestToken = ""
                APIAuth.sessionID = ""
                UserDefaults.standard.setValue(nil, forKey: "username")
                UserDefaults.standard.setValue(nil, forKey: "password")
                completion(true,nil)
                
            }.resume()
        }catch {
            completion(false,error)
        }
    }
    
    
    
     
}
