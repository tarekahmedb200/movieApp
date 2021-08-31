//
//  WatchListViewModel.swift
//  MovieApp
//
//  Created by lapshop on 8/30/21.
//


import Foundation
import RxCocoa
import RxSwift

class WatchListViewModel {
    
private var viewState = BehaviorRelay<state>(value: .none)
private var mediaType : MediaType = .movies
var watchList = [Media]()
     
var stateObservable : Observable<state>   {
    return viewState.asObservable().observeOn(MainScheduler.asyncInstance)
}
var mediaCategories  = ["movies","tv"]
    
enum state {
    case none
    case getWatchListMedia
    case navigateToViewController(viewController:UIViewController)
}
    
enum action {
    case clickCell(media:Media)
    case changeMediaType(mediaType:MediaType)
}
    
    
init() {
    loadWatchListMedia(mediaType: .movies)
}
  
    private func loadWatchListMedia(mediaType:MediaType) {
        MediaService.getMediaWatchList(mediaType: mediaType) {  (watchList, error) in
            guard error == nil else {
                return
            }
            
            self.watchList.removeAll()
            if let watchList = watchList {
                self.watchList = watchList
                self.viewState.accept(.getWatchListMedia)
            }
        }
    }

    
    func onAction(action:action)   {
        switch action {
        case .clickCell(let media):
            self.navigateToMediaDetailViewController(media: media)
        case .changeMediaType(let mediaType):
            self.mediaType = mediaType
            self.loadWatchListMedia(mediaType: mediaType)
        }
    }
    
    
    private func navigateToMediaDetailViewController(media:Media) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let mediaDetailsViewController = storyBoard .instantiateViewController(identifier: storyBoardIDS.mediaDetailsViewController.rawValue) as? MediaDetailsViewController ,
           let mediaID = media.id {
            let viewModel = MediaDetailsViewModel(mediaID: mediaID , mediaType: (self.mediaType == .movies) ?.movie: .tv)
            mediaDetailsViewController.viewModel = viewModel
            mediaDetailsViewController.hidesBottomBarWhenPushed = true
            viewState.accept(.navigateToViewController(viewController: mediaDetailsViewController))
        }
    }
    
}
