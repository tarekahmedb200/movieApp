//
//  CardView.swift
//  MovieApp
//
//  Created by lapshop on 5/13/21.
//

import Foundation
import UIKit



class CardView:UIView {
    private var cardVisible = false
    private var media : Media!
    private var isInWatchList : Bool = false
    private var isInFavouriteList : Bool = false
    weak var delegate : CardViewProtocol?
    var nextState:CardState {
            return cardVisible ? .collapsed : .expanded
    }
    private var animationProgressWhenInterrupted : CGFloat = 0
    private var parentViewController : UIViewController!
    private var visualEffect : UIVisualEffectView!
    private var runningAnimations = [UIViewPropertyAnimator]()
    
    @IBOutlet weak var mediaImageView: UIImageView!
  //  @IBOutlet weak var instructionLabel: UILabel!
  //  @IBOutlet weak var viewHandler: UIView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var mediaDetailsLabel: UILabel!
    @IBOutlet weak var mediaDescriptionLabel: UITextView!
    @IBOutlet weak var mediaGenresLabel: UILabel!
    
    @IBOutlet weak var addToFavouritesButton: UIButton!
    
    @IBOutlet weak var addToWatchListButton: UIButton!
    
    
    convenience init(frame:CGRect,viewController:UIViewController,visualEffect:UIVisualEffectView,media:Media) {
        self.init(frame:frame)
        instantiate(viewController: viewController,visualEffect: visualEffect, media: media)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func instantiate(viewController:UIViewController,visualEffect:UIVisualEffectView,media:Media) {
        self.parentViewController = viewController
        self.media = media
        self.visualEffect = visualEffect
        guard let cardView : CardView = loadFromNib() as? CardView else { return  }
        cardView.frame = bounds
        addSubview(cardView)
        setupUI(with : media)
      //  addGestureRecognizer()
    }
    
    private func setupUI(with media:Media) {
        //self.instructionLabel.text = "Drag Up For More Details"
        self.mediaTitleLabel.text = media.mediaTitle
        self.mediaDetailsLabel.text = "runtime: \(media.mediaRunTimeFormmated)"
        self.mediaGenresLabel.text = "genres : \(media.mediaGenres)"
        
        self.mediaDescriptionLabel.text = media.overview
        if let moviePosterPath = media.posterPath {
            DispatchQueue.main.async {
                self.mediaImageView.kf.setImage(with: movieDBURL.getPosterImage(path: moviePosterPath).url)
            }
        }

        self.mediaImageView.addRadius(by: 10)
      //  self.viewHandler.addRadius(by: 5)
        self.addRadius(by: 20)
    }
    
    
//    private  func addGestureRecognizer() {
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(recognizer:)))
//        self.viewHandler.addGestureRecognizer(panGestureRecognizer)
//    }
//
//    @objc private func handlePanGestureRecognizer(recognizer:UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            startInteractiveTransition(state: nextState, duration: 0.9)
//        case .changed:
//            let translation = recognizer.translation(in: self.viewHandler)
//            var fraction = translation.y / cardHeight
//            fraction = cardVisible ? fraction : -fraction
//            updateInteractiveTransition(fractionCompleted: fraction)
//        case .ended:
//            continueInteractiveTransition()
//        default:
//            break
//        }
//    }
//
//    private func startInteractiveTransition(state:CardState,duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            animateTransitionIfNeeded(state: state, duration: duration)
//        }
//
//        for animator in runningAnimations {
//            animator.pauseAnimation()
//            animationProgressWhenInterrupted = animator.fractionComplete
//        }
//    }
//
//    private func updateInteractiveTransition(fractionCompleted:CGFloat) {
//        for animator in runningAnimations {
//            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
//        }
//
//    }
//
//    private func continueInteractiveTransition() {
//        for animator in runningAnimations {
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//        }
//    }
//
//    private func animateTransitionIfNeeded(state:CardState,duration:TimeInterval) {
//        if runningAnimations.isEmpty {
//            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                switch state {
//                 case .expanded:
//                    self.frame.origin.y =  self.parentViewController.view.frame.height / 4
//                 case .collapsed:
//                    self.frame.origin.y =  self.parentViewController.view.frame.height - cardHandleAreaHeight
//                }
//            }
//
//            frameAnimator.addCompletion { _ in
//                self.cardVisible.toggle()
//                self.instructionLabel.text = self.cardVisible ? "Drag Down To Hide Details":"Drag Up For More Details"
//                self.runningAnimations.removeAll()
//            }
//
//            frameAnimator.startAnimation()
//            runningAnimations.append(frameAnimator)
//
//
//            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
//                            switch state {
//                            case .expanded:
//                                self.visualEffect.effect = UIBlurEffect(style: .dark)
//                            case .collapsed:
//                                self.visualEffect.effect = nil
//                            }
//                        }
//
//                        blurAnimator.startAnimation()
//                        runningAnimations.append(blurAnimator)
//
//
//        }
//    }
    
    
    
    @IBAction func addToWatchListButtonClicked(_ sender: Any) {
        
                self.isInWatchList.toggle()
        
        
                changeUIOfWatchListButton()
        
        
                guard let delegate = self.delegate else {
                    return
                }
                delegate.clickwatchListButton(media: self.media, watchList: self.isInWatchList)
        
    }
    

    @IBAction func addToFavouritesButtonClicked(_ sender: Any) {
        
            self.isInFavouriteList.toggle()
        
            changeUIOfFavoriteButton()
    
            guard let delegate = self.delegate else {
                return
            }
            delegate.clickFavouriteButton(media: self.media, favorite: self.isInFavouriteList)
        
    }
    

    
}

extension CardView : MediaDetailsViewModelProtocol {
    
    func setFavouriteButtonColor(with isInFavouriteList: Bool) {
        self.isInFavouriteList = isInFavouriteList
        changeUIOfFavoriteButton()
    }
    
    func setWatchListButtonColor(with isInWatchList: Bool) {
        self.isInWatchList = isInWatchList
        changeUIOfWatchListButton()
    }
    
}


extension CardView {
    
    private func changeUIOfFavoriteButton() {
        DispatchQueue.main.async {
            self.addToFavouritesButton.setBackgroundImage(UIImage(named: self.isInFavouriteList ? "Favourite-filled": "Favourite"), for: .normal)
        }
    }
    
    private func changeUIOfWatchListButton() {
        
        DispatchQueue.main.async {
            self.addToWatchListButton.setBackgroundImage(UIImage(named: self.isInWatchList ? "List-filled": "List"), for: .normal)
        }
        
    }
    
    
    
    
    
}




