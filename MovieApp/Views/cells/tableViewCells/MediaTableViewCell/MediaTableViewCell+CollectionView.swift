//
//  MediaTableViewCell+CollectionView.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension MediaTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  viewModel.mediaArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.MediaCollectionViewCell.rawValue, for: indexPath) as? MediaCollectionViewCell {
            let movie = viewModel.mediaArray[indexPath.row]
            cell.configureCell(movie: movie)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.mediaArray[indexPath.row]
        viewModel.onAction(action: .clickMedia(mediaID: selectedMovie.id ?? 0))
    }
    
    
     func regsiterCells() {
        collectionView.register(UINib(nibName: CellNibName.MediaCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.MediaCollectionViewCell.rawValue)
    }
    
}

