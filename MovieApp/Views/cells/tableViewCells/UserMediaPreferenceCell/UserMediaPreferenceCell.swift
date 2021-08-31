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
            UtitlyManager.shared.getPosterImage(with: moviePosterPath) { (data, error) in
                guard error == nil , let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.MediaImageView.image = UIImage(data: data)
                }
            }
        }
        
        mediaTitleLabel.text = media.mediaTitle
    }
    
}
