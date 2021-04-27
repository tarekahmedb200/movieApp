//
//  MovieDBAPI+MoviesList.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation

extension  MovieDBAPI  {
    
    static func getTrendingMovies(completion: @escaping ([Movie]?,Error?) -> Void) {
        guard  let url = movieDBURL.requestTrendingMovies(mediaType: .movie).url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            
            let f = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print(f)
            
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
