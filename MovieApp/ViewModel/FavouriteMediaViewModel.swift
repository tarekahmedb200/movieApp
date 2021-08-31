//
//  FavouriteMediaViewModel.swift
//  MovieApp
//
//  Created by lapshop on 8/31/21.
//

import Foundation

import Foundation
import RxCocoa
import RxSwift

class FavouriteMediaViewModel {
    
private var viewState = BehaviorRelay<state>(value: .none)
private var mediaType : MediaType = .movies
var favouriteList = [Media]()
     
var stateObservable : Observable<state>   {
    return viewState.asObservable().observeOn(MainScheduler.asyncInstance)
}
var mediaCategories  = ["movies","tv"]
    
enum state {
    case none
    case getFavouriteMedia
    case navigateToViewController(viewController:UIViewController)
}
    
enum action {
    case clickCell(media:Media)
    case changeMediaType(mediaType:MediaType)
}
    
    
init() {
    loadFavouriteMedia(mediaType: .movies)
}
  
    private func loadFavouriteMedia(mediaType:MediaType) {
        MediaService.getFavouriteMedia(mediaType: mediaType) {  (favouriteList, error) in
            guard error == nil else {
                return
            }
            
            self.favouriteList.removeAll()
            if let favouriteList = favouriteList {
                self.favouriteList = favouriteList
                self.viewState.accept(.getFavouriteMedia)
   
            }
        }
    }

    
    func onAction(action:action)   {
        switch action {
        case .clickCell(let media):
            self.navigateToMediaDetailViewController(media: media)
        case .changeMediaType(let mediaType):
            self.mediaType = mediaType
            self.loadFavouriteMedia(mediaType: mediaType)
        }
    }
    
    
    private func navigateToMediaDetailViewController(media:Media) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let mediaDetailsViewController = storyBoard .instantiateViewController(identifier: storyBoardIDS.mediaDetailsViewController.rawValue) as? MediaDetailsViewController ,
           let mediaID = media.id {
            let viewModel = MediaDetailsViewModel(mediaID: mediaID , mediaType:self.mediaType == .movies ? .movie:.tv )
            mediaDetailsViewController.viewModel = viewModel
            mediaDetailsViewController.hidesBottomBarWhenPushed = true
            viewState.accept(.navigateToViewController(viewController: mediaDetailsViewController))
        }
    }
    
}
