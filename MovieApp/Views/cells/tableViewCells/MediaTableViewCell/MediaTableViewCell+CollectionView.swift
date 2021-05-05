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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.MediaCollectionViewCell.rawValue, for: indexPath) as? MediaCollectionViewCell {
            cell.configureCell(title: "hello")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
    }
    
    
     func regsiterCells() {
        collectionView.register(UINib(nibName: CellNibName.MediaCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.MediaCollectionViewCell.rawValue)
    }
    
}

