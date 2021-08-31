//
//  Genre.swift
//  MovieApp
//
//  Created by lapshop on 5/31/21.
//

import Foundation

struct Genre : Codable {
    
    var id  : Int
    var name : String
    
    enum CodingKeys : String , CodingKey {
      case id
      case name 
    }
    
}
