//
//  MovieDBAPI+MoviesList.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation

extension  MovieDBAPI  {
    
    static func getMedia(mediaCategory:MediaCategory,mediaType:MediaType,completion: @escaping ([Movie]?,Error?) -> Void) {
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
                
//                let jsonString = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//                print(jsonString)
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let response = try jsonDecoder.decode(MovieResult.self, from: data)
                    
                    completion(response.movies,nil)
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
    
    
    
}
