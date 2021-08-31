//
//  mediaCollectionViewCell.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import UIKit
import Kingfisher

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
            DispatchQueue.main.async {
                self.mediaImageView.kf.setImage(with: movieDBURL.getPosterImage(path: moviePosterPath).url)
            }
            
        }
    }
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.mediaImageView.image = UIImage(named: AssetNames.placeHolder.rawValue)
        }
    }

}
