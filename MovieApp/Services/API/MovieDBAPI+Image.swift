//
//  MovieDBAPI+Image.swift
//  MovieApp
//
//  Created by lapshop on 5/5/21.
//

import Foundation

extension MovieDBAPI {
    
    static func getPosterImage(with path : String , completion: @escaping (Data?,Error?) ->Void ) {
        
        guard  let url = movieDBURL.getPosterImage(path: path).url  else {
            return
        }
        
        URLSession.shared.dataTask(with: url ) { (data, resposne, error) in
            
            guard let data = data else {
                completion(nil,error)
                return
            }
            completion(data,nil)
        }.resume()
        
    }
    
    
}
