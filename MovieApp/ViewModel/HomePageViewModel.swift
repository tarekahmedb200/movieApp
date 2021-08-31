//
//  HomePageViewModel.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//


import Foundation
import RxSwift
import RxCocoa

class HomePageViewModel {
    
    private var viewState = BehaviorRelay<state>(value: .loadingMedia)
    var categoriesNames = ["Trending","Popular","Top Rated"]
    var stateObservable : Observable<state>   {
        return viewState.asObservable()
    }
    
    enum state {
        case searchResultsLoaded
        case loadingMedia
        case logingout
    }
    
    enum action {
        case search(word:String)
        case logout
    }
    
    func onAction(action:action)   {
        switch action {
        case .search(let word):
            
            break
        case .logout:
           
            break
        }
    }
}


