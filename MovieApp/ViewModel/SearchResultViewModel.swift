//
//  SearchResultViewModel.swift
//  MovieApp
//
//  Created by lapshop on 8/28/21.
//

import Foundation
import RxCocoa
import RxSwift

class SearchResultViewModel {
    
    
    
private var viewState = BehaviorRelay<state>(value: .none)
    

var searchMediaArray = [Media]()
var stateObservable : Observable<state>   {
    return viewState.asObservable().observeOn(MainScheduler.asyncInstance)
}

enum state {
    case none
    case getSearchMedia
    case notFoundSearch
    case navigateToViewController(viewController:UIViewController)
}
    
enum action {
    case clickSearchButton(searchWord : String)
    case resultSearchCellClicked(media:Media)
}
    
    
init() {
   
}
  
    
private func getSearchMedia(with searchWord:String?) {
    
    guard let searchWord = searchWord , !searchWord.isEmpty else {
            return
    }
    MediaService.getSearchMedia(searchWord: searchWord) { (mediaArray, error) in
        
        guard error == nil else {
            self.viewState.accept(.notFoundSearch)
            return
        }
        
        guard let mediaArray = mediaArray else {
            return
        }
        
        self.searchMediaArray = mediaArray
        self.viewState.accept(.getSearchMedia)
    }
}
    
    func onAction(action:action)   {
        switch action {
        case .clickSearchButton(let searchWord):
            self.getSearchMedia(with: searchWord)
        case .resultSearchCellClicked(let media):
            self.navigateToMediaDetailViewController(media: media)
            break
        }
    }
    
    
    private func navigateToMediaDetailViewController(media:Media) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let mediaDetailsViewController = storyBoard .instantiateViewController(identifier: storyBoardIDS.mediaDetailsViewController.rawValue) as? MediaDetailsViewController ,
           let mediaID = media.id , let mediaType = media.type {
            let viewModel = MediaDetailsViewModel(mediaID: mediaID , mediaType:MediaType(rawValue: mediaType) ?? .movie)
            mediaDetailsViewController.viewModel = viewModel
            mediaDetailsViewController.hidesBottomBarWhenPushed = true
            viewState.accept(.navigateToViewController(viewController: mediaDetailsViewController))
        }
    }
    
    
    

}
