//
//  Movie.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation


struct Media : Codable {
    
    var id : Int?
    var posterPath : String?
    var adult: Bool?
    var overview : String?
    //for movies
    var releaseDate : String?
    // for tv shows
    var firstAirDate : String?
    //for movies
    var title : String?
    // for tv shows
    var name : String?
    var backdropPath : String?
    var popularity : Double?
    var runTime : Int?
    var genres : [Genre]?
    var type : String?
    
    var mediaTitle : String {
        return title ?? name ?? ""
    }
    
    var mediaDate : String {
        return releaseDate ?? firstAirDate ?? ""
    }
    
    var mediaRunTimeFormmated : String {
        let runTimeString = Date.minutesToHoursMinutes(minutes: runTime ?? 0)
        return "\(runTimeString.hours):\(runTimeString.minutes)"
    }
    
    
    var mediaGenres: String {
        var genresNames =  [String]()
        guard let genres = genres else {
            return ""
        }
        genresNames =  genres.map({
            return $0.name
        })
        
        return genresNames.joined(separator: ",")
    }
    
    
    
    
    
    enum CodingKeys : String , CodingKey {
        case id
        case genres
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case title
        case name
        case backdropPath = "backdrop_path"
        case popularity
        case runTime = "runtime"
        case type = "media_type"
    }
    
}


