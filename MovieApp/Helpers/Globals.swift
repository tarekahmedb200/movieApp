//
//  Globals.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation


enum storyBoardIDS  : String {
    case homePageTabBarController = "HomePageTabBarController"
}

enum assetNames : String {
    case movieLogo = "movieAppLogo"
}


struct APIAuth : Codable {
    static let ApiKey = "a7eb5170cc529b09434c39dd39566ffe"
    static var requestToken = ""
    static var sessionID = ""
    static let accountID = 0
}

enum MediaType: String {
    case all = "all"
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}

enum TimeWindows : String {
    case day = "day"
    case week = "week"
}



enum movieDBURL   {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apiKeyParameter = "?api_key="
    
    case requestToken
    case login
    case requestSession
    case requestGuestSession
    
    case requestTrendingMovies(mediaType: MediaType)
    
    var url : URL? {
        guard let url = URL(string: self.stringUrl) else {
            return nil
        }
        return url
    }
    
    var stringUrl : String {
        switch self {
        case .requestToken:
            return movieDBURL.baseUrl + "/authentication/token/new" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        
        case .login:
            return movieDBURL.baseUrl + "/authentication/token/validate_with_login" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
         
        case .requestSession:
            return movieDBURL.baseUrl + "/authentication/session/new" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
            
        case .requestGuestSession:
            return movieDBURL.baseUrl + "/authentication/guest_session/new" + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        
        case .requestTrendingMovies(let mediaType):
            return movieDBURL.baseUrl + "/trending/" + mediaType.rawValue + "/" + TimeWindows.week.rawValue + movieDBURL.apiKeyParameter + APIAuth.ApiKey
        }
    }
    
    
}
