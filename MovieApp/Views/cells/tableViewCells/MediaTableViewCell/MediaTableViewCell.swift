//
//  MediaTableViewCell.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
   
    @IBOutlet weak var collectionView: UICollectionView!
    override class func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configureCell()  {
        regsiterCells() 
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
    }
}
