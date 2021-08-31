//
//  SearchResultViewController.swift
//  MovieApp
//
//  Created by lapshop on 8/28/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class SearchResultViewController: UIViewController  {
    
    var viewModel : SearchResultViewModel!
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        setupObservers()
        registerCells()
    }
    
    
    private func setupObservers() {
        viewModel.stateObservable
            .subscribe(onNext: { [weak self] in
                guard let weakself = self else {
                    return
                }
                switch $0 {
                case .none:
                    break
                case .getSearchMedia:
                    DispatchQueue.main.async {
                        weakself.tableView.reloadData()
                    }
                case .notFoundSearch:
                    break
                case .navigateToViewController(let viewController):
                    weakself.presentingViewController?.navigationController?.pushViewController(viewController, animated: true)
                }
            }).disposed(by: disposeBag)
    }

    
    
}


extension SearchResultViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.onAction(action: .clickSearchButton(searchWord: searchController.searchBar.text!))
    }
}



