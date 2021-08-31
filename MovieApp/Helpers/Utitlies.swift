//
//  Utitlies.swift
//  MovieApp
//
//  Created by lapshop on 5/5/21.
//

import Foundation

class UtitlyManager {
  static let shared = UtitlyManager()
  private init() {}
   
    
    func getPosterImage(with path:String,completion: @escaping(Data?,Error?) ->Void) {
        ImageService.getImagePoster(with: path) { (data, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
    
            completion(data,nil)
        }
    }
    
}
