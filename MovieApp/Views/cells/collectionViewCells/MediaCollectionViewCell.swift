//
//  mediaCollectionViewCell.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mediaTitleLabel: UILabel!
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRadius(by: 15)
    }
    
    
    func configureCell(movie:Media) {
        self.mediaTitleLabel.text = movie.mediaTitle
        if let moviePosterPath = movie.posterPath {
            UtitlyManager.shared.getPosterImage(with: moviePosterPath) { (data, error) in
                guard error == nil , let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.mediaImageView.image = UIImage(data: data)
                }
               
            }
        }
      
    }
    
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.mediaImageView.image = UIImage(named: AssetNames.placeHolder.rawValue)
        }
    }

}
