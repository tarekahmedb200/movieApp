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
    weak var delegate: MediaDetailsViewModelProtocol?
    private var viewState = BehaviorRelay<state>(value: .none)
    private var mediaType : MediaType = .all
    private var mediaID : Int = 0
   
    
    var stateObservable : Observable<state>   {
        return viewState.asObservable().observeOn(MainScheduler.asyncInstance)
    }
    
    
    enum state {
        case none
        case loadingMediaDetails(media:Media)
        case favouriteButtonClicked
        case addToListButtonClicked
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
            
            self.viewState.accept(.addToListButtonClicked)
        }
    }
    
    
    private func addMediaToWatchList(with mediaType:MediaType,and mediaID:Int,watchList:Bool) {
        MediaService.addMediaToWatchList(mediaType: mediaType, mediaID: mediaID, watchList:  watchList) { (success, error) in
          
          guard error == nil else {
              self.viewState.accept(.errorLoadingMedia(errorMessage: error?.localizedDescription ?? ""))
               return
          }
          self.viewState.accept(.addToListButtonClicked)
        }
    }
    
    private func loadWatchListMedia(mediaType:MediaType) {
        MediaService.getMediaWatchList(mediaType: mediaType) {  (watchList, error) in
            guard error == nil else {
                return
            }
            
            if let watchList = watchList {
                
                guard let delegate = self.delegate else {
                    return
                }
                
                if watchList.contains(where: {$0.id == self.mediaID}) {
                    delegate.setWatchListButtonColor(with: true)
                }else {
                    delegate.setWatchListButtonColor(with: false)
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
                
                guard let delegate = self.delegate else {
                    return
                }
                
                if favoriteMovies.contains(where: {$0.id == self.mediaID}) {
                    delegate.setFavouriteButtonColor(with: true)
                }else {
                    delegate.setFavouriteButtonColor(with: false)
                }
            }
           
        }
    }
}


extension MediaDetailsViewModel: CardViewProtocol {
    func clickFavouriteButton(media: Media, favorite: Bool) {
        addMediaToFavorites(with: self.mediaType, and: self.mediaID, favorite: favorite)
    }
    
    func clickwatchListButton(media: Media, watchList: Bool) {
        addMediaToWatchList(with: self.mediaType, and: self.mediaID, watchList: watchList)
    }

}
