//
//  MovieListService.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation

class MediaService {
    
    static func getMedia(mediaCategory:MediaCategory,mediaType:MediaType,completion:@escaping ([Media]?,Error?)-> Void) {
        
        MovieDBAPI.getMedia(mediaCategory:mediaCategory,mediaType: mediaType) { (movies, error) in
            
            guard  error == nil else {
                completion(nil,error)
                return
            }
            
            completion(movies,nil)
        }
    }
    
    static func getMediaDetails(mediaID:Int,mediaType:MediaType,completion:@escaping (Media?,Error?)-> Void) {
        
        MovieDBAPI.getMediaDetails(mediaID:mediaID,mediaType: mediaType) { (movie, error) in
            
            guard  error == nil else {
                completion(nil,error)
                return
            }
            
            completion(movie,nil)
        }
    }
    
    
    static func addMediaToFavourites(mediaType:MediaType,mediaID:Int,favorite:Bool,completion:@escaping (Bool,Error?)-> Void) {
        
        MovieDBAPI.addMediaToFavourites(with: mediaType, and: mediaID, favorite: favorite) { (success, error) in
            
            if success {
                completion(true,nil)
            }else {
                completion(false,error)
            }
        }
    }
    
    static func addMediaToWatchList(mediaType:MediaType,mediaID:Int,watchList:Bool,completion:@escaping (Bool,Error?)-> Void) {
        
        MovieDBAPI.addMediaToWatchList(with: mediaType, and: mediaID, watchList: watchList) { (success, error) in
            
            if success {
                completion(true,nil)
            }else {
                completion(false,error)
            }
        }
    }
    
    
    static func getMediaWatchList(mediaType:MediaType,completion:@escaping ([Media]?,Error?)-> Void) {
        
        MovieDBAPI.getWatchList(mediaType: mediaType) { (watchListMedia, error) in
            
            guard  error == nil else {
                completion(nil,error)
                return
            }
            completion(watchListMedia,nil)
        }
    }
    
    static func getFavouriteMedia(mediaType:MediaType,completion:@escaping ([Media]?,Error?)-> Void) {
        
        MovieDBAPI.getFavouriteList(mediaType: mediaType) { (favoriteMedia, error) in
            
            guard  error == nil else {
                completion(nil,error)
                return
            }
            completion(favoriteMedia,nil)
        }
    }
    
    static func getSearchMedia(searchWord:String,completion:@escaping ([Media]?,Error?)-> Void) {
        
        MovieDBAPI.getSearchMedia(searchWord: searchWord) { (movies, error) in
            
            guard  error == nil else {
                completion(nil,error)
                return
            }
            
            completion(movies,nil)
        }
    }
    
    
    
    
    
    
    
}
