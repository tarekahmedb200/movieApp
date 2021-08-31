//
//  WatchListViewController.swift
//  MovieApp
//
//  Created by lapshop on 8/30/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class WatchListViewController : UIViewController {
    
    var viewModel = WatchListViewModel()
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        setupSegmentControl()
        registerCells()
        setupObservers()
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
                case .getWatchListMedia:
                    DispatchQueue.main.async {
                        weakself.tableView.reloadData()
                    }
                case .navigateToViewController(let viewController):
                    weakself.navigationController?.pushViewController(viewController, animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupSegmentControl() {
        let mySegmentedControl = UISegmentedControl(items: viewModel.mediaCategories)
        mySegmentedControl.selectedSegmentIndex = 0
        //mySegmentedControl.tintColor = UIColor.yellow
       // mySegmentedControl.backgroundColor = UIColor.black
        mySegmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        self.navigationItem.titleView = mySegmentedControl
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        
        let mediaType = MediaType(rawValue:viewModel.mediaCategories[sender.selectedSegmentIndex])
        viewModel.onAction(action: .changeMediaType(mediaType: mediaType ?? .movies))
    }
    
}
