//
//  ImageService.swift
//  MovieApp
//
//  Created by lapshop on 5/5/21.
//

import Foundation

class ImageService {
    
    static func getImagePoster(with path:String,completion: @escaping (_ data:Data?,_ error:Error?) -> Void) {
        
        MovieDBAPI.getPosterImage(with: path) { (data, error) in
                guard error == nil else {
                    completion(nil,error)
                    return
                }
        
                completion(data,nil)
        }
    }
    
    
    
}
