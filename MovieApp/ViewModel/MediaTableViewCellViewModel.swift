//
//  MediaTableViewCellViewModel.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import Foundation
import RxSwift
import RxCocoa

class MediaTableViewCellViewModel {
    
    private var viewState = BehaviorRelay<state>(value: .none)
    private var tableViewSection : Int = 0
    private var mediaType  : MediaType = .movie
    init(tableViewSection:Int) {
        self.tableViewSection = tableViewSection
        loadMedia(with: .movie)
    }
    
    var mediaArray = [Media]()
    var stateObservable : Observable<state>   {
        return viewState.asObservable()
    }
    
    enum state {
        case none
        case loadingMedia
        case errorLoadingMedia(errorMessage:String)
        case navigateToViewController(viewController:UIViewController)
    }
    
    enum action {
        case clickMedia(mediaID:Int)
        case changeMediaType(mediaType:MediaType)
    }
    
    func onAction(action:action)   {
        switch action {
        case .clickMedia(let mediaID):
            navigateToMediaDetailViewController(mediaID:mediaID)
            break
        case .changeMediaType(let mediaType):
            self.mediaType = mediaType
            loadMedia(with: mediaType)
            break
        }
    }
    
    
    func loadMedia(with mediaType:MediaType) {
        let mediaCategory = MediaCategory(rawValue: self.tableViewSection)
        switch mediaCategory {
        case .trending:
            getMedia(with: .trending, and: mediaType)
            break
        case .popular:
            getMedia(with: .popular, and: mediaType)
            break
        case .topRated:
            getMedia(with: .topRated, and: mediaType)
            break
        case .none:
            break
        }
    }
    
    
    
    private func getMedia(with mediaCategory:MediaCategory,and mediaType:MediaType) {
        MediaService.getMedia(mediaCategory:mediaCategory,mediaType: mediaType) { (mediaArray, error) in
            guard error == nil else {
                self.viewState.accept(.errorLoadingMedia(errorMessage: error?.localizedDescription ?? ""))
                return
            }
            
            guard let mediaArray = mediaArray else {
                return
            }
            
            self.mediaArray = mediaArray
            self.viewState.accept(.loadingMedia)
        }
    }
    
    private func navigateToMediaDetailViewController(mediaID:Int) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let mediaDetailsViewController = storyBoard .instantiateViewController(identifier: storyBoardIDS.mediaDetailsViewController.rawValue) as? MediaDetailsViewController {
            let viewModel = MediaDetailsViewModel(mediaID: mediaID, mediaType:self.mediaType)
            mediaDetailsViewController.viewModel = viewModel
            mediaDetailsViewController.hidesBottomBarWhenPushed = true
            viewState.accept(.navigateToViewController(viewController: mediaDetailsViewController))
        }
    }
    
    
}


