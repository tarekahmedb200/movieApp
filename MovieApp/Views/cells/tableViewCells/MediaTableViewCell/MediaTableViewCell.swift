//
//  MediaTableViewCell.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import UIKit
import RxSwift
import RxCocoa

class MediaTableViewCell: UITableViewCell {
    var viewModel : MediaTableViewCellViewModel!
    var delegate : MediaTableViewCellProtocol?
    private var disposeBag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!
    override class func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configureCell(viewModel:MediaTableViewCellViewModel)  {
        self.viewModel = viewModel
        regsiterCells() 
        collectionView.delegate = self
        collectionView.dataSource = self
        setupObservers()
    }
    
    private func setupObservers() {
        viewModel.stateObservable
            .subscribe(onNext: {
                switch $0 {
                case .none:
                    print("loading")
                case .loadingMedia:
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.collectionView.scrollToItem(at: IndexPath(index: 0), at: .left, animated: true)
                    }
                    
                case .errorLoadingMedia(let errorMessage):
                    DispatchQueue.main.async {
                        print(errorMessage)
                    }
                    
                case .navigateToViewController(let viewController):
                    DispatchQueue.main.async {
                        guard let delegate = self.delegate else {
                            return
                        }
                        delegate.navigateToMediaDetailsViewController(viewController: viewController)
                    }
                }
                
            }).disposed(by: disposeBag)
  }
    
    
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {

        viewModel.onAction(action: .changeMediaType(mediaType:sender.selectedSegmentIndex == 0 ? .movie : .tv ))
    }
}
