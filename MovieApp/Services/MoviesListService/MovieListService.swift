//
//  MovieListService.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation

class MovieListService {
    
    static func getTrendingMoves(completion:@escaping ([Movie]?,Error?)-> Void) {
        
        MovieDBAPI.getTrendingMovies { (movies, error) in
            
            guard  error == nil else {
                completion(nil,error)
                return
            }
            
            completion(movies,nil)
        }
    }
    
    
    
    
    
    
    
}
