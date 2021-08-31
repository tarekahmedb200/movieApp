//
//  FavouriteMediaListViewController+tableView.swift
//  MovieApp
//
//  Created by lapshop on 8/31/21.
//

import Foundation
import UIKit

extension FavouriteMediaListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.UserMediaPreferenceCell.rawValue) as? UserMediaPreferenceCell {
            
            let media = viewModel.favouriteList[indexPath.row]
            cell.configureCell(media: media)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = viewModel.favouriteList[indexPath.row]
        viewModel.onAction(action: .clickCell(media: media))
    }
    
    
    func registerCells() {
        tableView.register(UINib(nibName: CellNibName.UserMediaPreferenceCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifier.UserMediaPreferenceCell.rawValue)
    }
    
}
