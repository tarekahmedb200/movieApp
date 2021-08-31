//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by lapshop on 5/8/21.
//

import Foundation
import RxSwift
import RxCocoa

class MediaDetailsViewController : UIViewController{
    
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
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
                case .loadingMediaDetails(let media):
                    weakself.setupUI(with :media)
                case .favouriteButtonClicked:
                    
                    break
                case .addToListButtonClicked:
                    
                    break
                case .none:
                    break
                case .errorLoadingMedia(let errorMessage):
                    AlertMessages.shared.showMessage(title: "Error", message: errorMessage, in: weakself)
                }
            }).disposed(by: disposeBag)
    }

    
    
    private func setupCard(with media:Media) {
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        let cardView = CardView(frame:
                                    CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight,
                                    width: self.view.bounds.width, height: cardHeight),
                                viewController: self,
                                visualEffect: visualEffectView, media: media)
        
        cardView.delegate = viewModel
        viewModel.delegate = cardView
        cardView.clipsToBounds = true
        self.view.addSubview(cardView)
    }
    
    private func setupUI(with media:Media) {
        if let mediaPosterPath = media.posterPath {
            UtitlyManager.shared.getPosterImage(with: mediaPosterPath) { (data, error) in
                guard error == nil , let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.mediaImageView.image = UIImage(data: data)
                }
               
            }
        }
        self.mediaTitleLabel.text = media.mediaTitle

        setupCard(with: media)
    }
    
    
    
    
}


