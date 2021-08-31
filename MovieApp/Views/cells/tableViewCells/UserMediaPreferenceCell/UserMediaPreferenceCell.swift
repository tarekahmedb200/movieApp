//
//  UserMediaPreferenceCell.swift
//  MovieApp
//
//  Created by lapshop on 8/30/21.
//

import UIKit

class UserMediaPreferenceCell: UITableViewCell {

    @IBOutlet weak var mediaTitleLabel: UILabel!
    @IBOutlet weak var MediaImageView: UIImageView!
    
    func configureCell(media:Media) {
        if let moviePosterPath = media.posterPath {
            DispatchQueue.main.async {
                self.MediaImageView.kf.setImage(with: movieDBURL.getPosterImage(path: moviePosterPath).url)
            }
        }
        
        mediaTitleLabel.text = media.mediaTitle
    }
    
}
