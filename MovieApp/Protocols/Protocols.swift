//
//  Protocols.swift
//  MovieApp
//
//  Created by lapshop on 5/31/21.
//

import UIKit

protocol CardViewProtocol:class {
    func clickFavouriteButton(media:Media,favorite:Bool)
    func clickwatchListButton(media:Media,watchList:Bool)
}

protocol MediaTableViewCellProtocol:class {
    func navigateToMediaDetailsViewController(viewController:UIViewController)
}

protocol MediaDetailsViewModelProtocol : class {
    func setFavouriteButtonColor(with isInFavouriteList:Bool)
    func setWatchListButtonColor(with isInWatchList:Bool)
}
