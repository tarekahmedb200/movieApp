//
//  HomePageViewController+tableView.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension HomePageViewController: UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  viewModel.categoriesNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.MediaTableViewHeader.rawValue) as? MediaTableViewHeader  else {
            return nil
        }
        header.catergotyNameLabel.text = viewModel.categoriesNames[section]
        return header
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.MediaTableViewCell.rawValue) as? MediaTableViewCell {
            let mediaTableViewCellViewModel = MediaTableViewCellViewModel(tableViewSection: indexPath.section)
            cell.configureCell(viewModel: mediaTableViewCellViewModel)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func registerCells() {
        tableView.register(UINib(nibName: CellNibName.MediaTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifier.MediaTableViewCell.rawValue)
        
        tableView.register(UINib(nibName: CellNibName.MediaTableViewHeader.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifier.MediaTableViewHeader.rawValue)
    }
}

extension HomePageViewController : MediaTableViewCellProtocol {
    func navigateToMediaDetailsViewController(viewController: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
