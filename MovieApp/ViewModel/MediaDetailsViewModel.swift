//
//  MediaDetailsViewModel.swift
//  MovieApp
//
//  Created by lapshop on 5/9/21.
//

import Foundation
import RxSwift
import RxCocoa

class MediaDetailsViewModel {
    private var viewState = BehaviorRelay<state>(value: .none)
    private var mediaType : MediaType = .all
    private var mediaID : Int = 0
   
    var stateObservable : Observable<state>   {
        return viewState.asObservable().observeOn(MainScheduler.asyncInstance)
    }
    
    enum action {
        case clickFavouriteButton(addToFavorite:Bool)
        case clickWatchListButton(addToWatchList:Bool)
    }
    
    enum state {
        case none
        case loadingMediaDetails(media:Media)
        case setFavoriteButton(favorite:Bool)
        case setWatchListButton(watchList:Bool)
        case errorLoadingMedia(errorMessage:String)
    }
    
    init(mediaID:Int,mediaType:MediaType) {
        self.mediaType = mediaType
        self.mediaID = mediaID
        getMediaDetails(with: mediaID, and: mediaType)
        loadWatchListMedia(mediaType: mediaType == .movie ? .movies : mediaType)
        loadFavoriteMedia(mediaType: mediaType == .movie ? .movies : mediaType)
    }
    
    
    private func getMediaDetails(with mediaID:Int,and mediaType:MediaType) {
        MediaService.getMediaDetails(mediaID:mediaID,mediaType: mediaType) { (media, error) in
            guard error == nil else {
                self.viewState.accept(.errorLoadingMedia(errorMessage: error?.localizedDescription ?? ""))
                return
            }

            guard let media = media else {
                return
            }
            self.viewState.accept(.loadingMediaDetails(media: media))
        }
    }

    private func addMediaToFavorites(with mediaType:MediaType,and mediaID:Int,favorite:Bool) {
        MediaService.addMediaToFavourites(mediaType: mediaType, mediaID: mediaID, favorite: favorite) { (success, error) in
            
          guard error == nil else {
              self.viewState.accept(.errorLoadingMedia(errorMessage: error?.localizedDescription ?? ""))
               return
          }
            
            self.viewState.accept(.setFavoriteButton(favorite: favorite))
        }
    }
    
    
    private func addMediaToWatchList(with mediaType:MediaType,and mediaID:Int,watchList:Bool) {
        MediaService.addMediaToWatchList(mediaType: mediaType, mediaID: mediaID, watchList:  watchList) { (success, error) in
          
          guard error == nil else {
              self.viewState.accept(.errorLoadingMedia(errorMessage: error?.localizedDescription ?? ""))
               return
          }
            self.viewState.accept(.setWatchListButton(watchList: watchList))
        }
    }
    
    private func loadWatchListMedia(mediaType:MediaType) {
        MediaService.getMediaWatchList(mediaType: mediaType) {  (watchList, error) in
            guard error == nil else {
                return
            }
            
            if let watchList = watchList {
                
                if watchList.contains(where: {$0.id == self.mediaID}) {
                    self.viewState.accept(.setWatchListButton(watchList: true))
                }

            }
        }
    }
    
    private func loadFavoriteMedia(mediaType:MediaType) {
        MediaService.getFavouriteMedia(mediaType: mediaType) {  (favoriteMovies, error) in
            guard error == nil else {
                return
            }
            
            if let favoriteMovies = favoriteMovies {
                if favoriteMovies.contains(where: {$0.id == self.mediaID}) {
                    self.viewState.accept(.setFavoriteButton(favorite: true))
                }
            }
           
        }
    }
    
    func onAction(action:action)   {
        switch action {
        case .clickFavouriteButton(let addToFavorite):
            self.addMediaToFavorites(with: self.mediaType, and: self.mediaID, favorite: addToFavorite)
            break
        case .clickWatchListButton(let addToWatchList):
            self.addMediaToWatchList(with: self.mediaType, and: self.mediaID, watchList: addToWatchList)
            break
        }
    }
    
    
}

