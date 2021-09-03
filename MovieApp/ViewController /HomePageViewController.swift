//
//  HomePageViewController.swift
//  MovieApp
//
//  Created by lapshop on 5/2/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomePageViewController: UIViewController {
    var viewModel = HomePageViewModel()
    var disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate  = self
        registerCells()
        setupObservers()
        setupSearchController()
    }
    
    
    private func setupObservers() {
        viewModel.stateObservable
            .subscribe(onNext: {
                switch $0 {
                case .searchResultsLoaded,.loadingMedia:
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .logingout:
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupSearchController() {
        if let searchResultViewController = storyboard?.instantiateViewController(identifier: "SearchResultViewController") as? SearchResultViewController {
            let searchResultViewModel = SearchResultViewModel()
            let searchController  = UISearchController(searchResultsController: searchResultViewController)
            if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textField.backgroundColor = #colorLiteral(red: 0.05599083297, green: 0.2374675888, blue: 0.4338702629, alpha: 1)
            }
            
            searchResultViewController.viewModel = searchResultViewModel
            searchController.searchResultsUpdater = searchResultViewController
            self.navigationItem.searchController = searchController
        }
    }
    
    
}




