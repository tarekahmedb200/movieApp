//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by lapshop on 5/8/21.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher

class MediaDetailsViewController : UIViewController{
    
    
    private var favorite  = false
    private var watchList  = false
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardMediaImageView: UIImageView!
    @IBOutlet weak var cardMediaTitleLabel: UILabel!
    @IBOutlet weak var cardMediaRuntimeLabel: UILabel!
    @IBOutlet weak var cardMediaDescriptionLabel: UITextView!
    @IBOutlet weak var cardMediaGenresLabel: UILabel!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    @IBOutlet weak var addToWatchListButton: UIButton!
    
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mediaImageView: UIImageView!
    var viewModel : MediaDetailsViewModel!
    let visualEffectView = UIVisualEffectView()
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
    }
    
    
    private func setupObservers() {
        viewModel.stateObservable
            .subscribe(onNext: { [weak self] in
                guard let weakself = self else {
                    return
                }
                switch $0 {
                case .none:
                    weakself.activityIndicator.startAnimating()
                    break
                case .loadingMediaDetails(let media):
                    weakself.activityIndicator.stopAnimating()
                    weakself.activityIndicator.isHidden = true
                    weakself.setupUI(with :media)
                    
                case .setFavoriteButton(let favorite):
                    weakself.activityIndicator.stopAnimating()
                    weakself.activityIndicator.isHidden = true
                    weakself.favorite = favorite
                    weakself.changeUIOfFavoriteButton(favorite: favorite)
                    break
                case .setWatchListButton(let watchList):
                    weakself.activityIndicator.stopAnimating()
                    weakself.activityIndicator.isHidden = true
                    weakself.watchList = watchList
                    weakself.changeUIOfWatchListButton(watchList: watchList)
                    break
                
                case .errorLoadingMedia(let errorMessage):
                    AlertMessages.shared.showMessage(title: "Error", message: errorMessage, in: weakself)
                }
            }).disposed(by: disposeBag)
    }

    
    
    private func setupCard(with media:Media) {
        self.cardMediaTitleLabel.text = media.mediaTitle
        self.cardMediaRuntimeLabel.text = "runtime: \(media.mediaRunTimeFormmated)"
        self.cardMediaGenresLabel.text = "genres : \(media.mediaGenres)"
        
        self.cardMediaDescriptionLabel.text = media.overview
        if let moviePosterPath = media.posterPath {
            DispatchQueue.main.async {
                self.cardMediaImageView.kf.setImage(with: movieDBURL.getPosterImage(path: moviePosterPath).url)
            }
        }
        self.cardMediaImageView.addRadius(by: 10)
        scrollView.addRadius(by: 20)
        
        self.changeUIOfFavoriteButton(favorite: self.favorite)
        self.changeUIOfFavoriteButton(favorite: self.watchList)
    }
    
    
    private func setupUI(with media:Media) {
        if let moviePosterPath = media.posterPath {
            DispatchQueue.main.async {
                self.mediaImageView.kf.setImage(with: movieDBURL.getPosterImage(path: moviePosterPath).url)
            }
        }
        setupCard(with: media)
    }
    
    
    @IBAction func addToWatchListButtonClicked(_ sender: Any) {
        
        let title : String = self.watchList ? "remove from watchlist" : "add to WatchList"
        
        let message : String = self.watchList ? "are you sure you want to remvoe it from WatchList ? " : "are you sure you want to add it to WatchList ? "
        
        AlertMessages.shared.showMessage(title: title, message: message, in: self, with: "yes") { _ in
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.watchList.toggle()
            self.viewModel.onAction(action: .clickWatchListButton(addToWatchList: self.watchList))
        }
        
    }
    
    @IBAction func addToFavouritesButtonClicked(_ sender: Any) {
        
        let title : String = self.watchList ? "remove from favorites" : "add to favorites"
        
        let message : String = self.watchList ? "are you sure you want to remvoe it from favorites ? " : "are you sure you want to add it to favorites ? "
        
        AlertMessages.shared.showMessage(title: title, message: message, in: self, with: "yes") { _ in
            self.activityIndicator.isHidden = false 
            self.activityIndicator.startAnimating()
            self.favorite.toggle()
            self.viewModel.onAction(action: .clickFavouriteButton(addToFavorite:self.favorite ))
        }
    }
    
    
    
    private func changeUIOfFavoriteButton(favorite:Bool) {
        DispatchQueue.main.async {
            self.addToFavouritesButton.setBackgroundImage(UIImage(named: favorite ? "removeHeart": "addHeart"), for: .normal)
        }
    }
    
    private func changeUIOfWatchListButton(watchList:Bool) {
        
        DispatchQueue.main.async {
            self.addToWatchListButton.setBackgroundImage(UIImage(named: watchList ? "removeBookmark": "addBookmark"), for: .normal)
        }
        
    }
    
    
    
    
}


