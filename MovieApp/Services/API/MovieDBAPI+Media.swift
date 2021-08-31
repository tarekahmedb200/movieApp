//
//  MovieDBAPI+Media.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation

extension  MovieDBAPI  {
    
    static func getMedia(mediaCategory:MediaCategory,mediaType:MediaType,completion: @escaping ([Media]?,Error?) -> Void) {
        var choosenUrl : URL?
        switch mediaCategory {
        case .topRated:
            choosenUrl = movieDBURL.requestTopRatedMovies(mediaType: mediaType).url
        case .popular:
            choosenUrl = movieDBURL.requestPopularMovies(mediaType: mediaType).url
        case .trending:
            choosenUrl = movieDBURL.requestTrendingMovies(mediaType: mediaType).url
        }
        
        guard  let url = choosenUrl else {
            return
        }
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completion(nil,error)
                    return
                }
                
//                let dd = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//                print(dd)
//
                let jsonDecoder = JSONDecoder()
                
                do {
                    let response = try jsonDecoder.decode(MediaResult.self, from: data)
                    
                    completion(response.media,nil)
                }catch {
                    do {
                        let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                        completion(nil,errorResponse)
                    }catch {
                        completion(nil,error)
                    }
                }
            }.resume()
    }
    
    
    
    static func getMediaDetails(mediaID:Int,mediaType:MediaType,completion: @escaping (Media?,Error?) -> Void) {
       
        
        guard  let url = movieDBURL.requestMediaDetails(mediaId: mediaID, mediaType: mediaType).url else {
            return
        }
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
               
                
                guard let data = data else {
                    completion(nil,error)
                    return
                }
                
//                let jsonString = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//                print(jsonString)
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let response = try jsonDecoder.decode(Media.self, from: data)
                    
                    completion(response,nil)
                }catch {
                    print(error)
                    do {
                        let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                        completion(nil,errorResponse)
                    }catch {
                        completion(nil,error)
                    }
                }
            }.resume()
    }
    
    
    
    static func addMediaToFavourites(with mediaType : MediaType ,and mediaID:Int , favorite:Bool,completion:@escaping (Bool,Error?) -> Void) {
        guard  let url = movieDBURL.addToFavourites.url else {
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let body = FavouriteRequest(mediaType: mediaType.rawValue, mediaID: mediaID, favorite: favorite)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(false,error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
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
    
    
    static func addMediaToWatchList(with mediaType : MediaType ,and mediaID:Int , watchList:Bool,completion:@escaping (Bool,Error?) -> Void) {
        guard  let url = movieDBURL.addToWatchList.url else {
            return
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let body = WatchListRequest(mediaType: mediaType.rawValue, mediaID: mediaID, watchlist: watchList)
            request.httpBody = try encoder.encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(false,error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
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
    
    
    static func getWatchList(mediaType:MediaType,completion:@escaping ([Media]?,Error?) -> Void) {
        guard  let url = movieDBURL.getWatchListMedia(mediaType: mediaType).url else {
            return
        }
        print(url)
        do {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completion(nil,error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let resutls = try jsonDecoder.decode(MediaResult.self, from: data)
                    completion(resutls.media,nil)
                }catch {
                   
                    do {
                        let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                        completion(nil,errorResponse)
                    }catch {
                        completion(nil,error)
                    }
                }
            }.resume()
        }catch {
            completion(nil,error)
        }
    }
    
    static func getFavouriteList(mediaType:MediaType,completion:@escaping ([Media]?,Error?) -> Void) {
        guard  let url = movieDBURL.getFavouriteMedia(mediaType: mediaType).url else {
            return
        }
        
        
        do {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completion(nil,error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let resutls = try jsonDecoder.decode(MediaResult.self, from: data)
                    completion(resutls.media,nil)
                }catch {
                    do {
                        let errorResponse = try jsonDecoder.decode(ErrorResponse.self, from: data)
                        completion(nil,errorResponse)
                    }catch {
                        completion(nil,error)
                    }
                }
            }.resume()
        }catch {
            completion(nil,error)
        }
    }
    
    
    static func getSearchMedia(searchWord:String,completion: @escaping ([Media]?,Error?) -> Void) {
        
        
            guard let url = movieDBURL.searchMedia(searchWord: searchWord).url else {
                return
            }
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print(error)
                    completion(nil,error)
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
//                let jsonString = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
//                print(jsonString)
                
                
                do {
                    let response = try jsonDecoder.decode(MediaResult.self, from: data)
                    
                    completion(response.media,nil)
                }catch {
                    print(error)
                    completion(nil,error)
                }
            }.resume()
    }
    
    
    

}
