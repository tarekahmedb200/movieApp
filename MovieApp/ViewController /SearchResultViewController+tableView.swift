//
//  SearchResultViewController+tableView.swift
//  MovieApp
//
//  Created by lapshop on 8/29/21.
//

import Foundation
import UIKit

extension SearchResultViewController : UITableViewDelegate , UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchMediaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.MediaSearchResultCell.rawValue) as? MediaSearchResultTableViewCell {
            
            let media = viewModel.searchMediaArray[indexPath.row]
            cell.configureCell(with: media)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = viewModel.searchMediaArray[indexPath.row]
        viewModel.onAction(action: .resultSearchCellClicked(media: media))
    }
    
    
    
    func registerCells() {
        tableView.register(UINib(nibName: CellNibName.MediaSearchResultCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifier.MediaSearchResultCell.rawValue)
    }
    
    
}
