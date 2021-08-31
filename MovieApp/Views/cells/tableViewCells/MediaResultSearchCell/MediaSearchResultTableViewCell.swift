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
            UtitlyManager.shared.getPosterImage(with: moviePosterPath) { (data, error) in
                guard error == nil , let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.mediaImageView.image = UIImage(data: data)
                }
            }
        }
        self.mediaImageView.addRadius(by: 10)
        mediaTitleLabel.text = media.mediaTitle
        
        mediaDateLabel.text = media.mediaDate
    }
    
    
}
