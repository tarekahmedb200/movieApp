//
//  MediaSearchResultTableViewCell.swift
//  MovieApp
//
//  Created by lapshop on 8/29/21.
//

import UIKit

class MediaSearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaTitleLabel: UILabel!
    
    @IBOutlet weak var mediaDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with media:Media) {
        if let moviePosterPath = media.posterPath {
            DispatchQueue.main.async {
                self.mediaImageView.kf.setImage(with: movieDBURL.getPosterImage(path: moviePosterPath).url)
            }
        }
        self.mediaImageView.addRadius(by: 10)
        mediaTitleLabel.text = media.mediaTitle
        
        mediaDateLabel.text = media.mediaDate
    }
    
    
}
