//
//  AlertMessages.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation
import UIKit

class AlertMessages {
    
    static let shared = AlertMessages()
    
    private init() {}
    
    
    func showMessage(title:String,message:String?,in viewController:UIViewController) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message ?? nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showMessage(title:String,message:String?,in viewController:UIViewController,with actiontitle:String?,with action :((UIAlertAction)->Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message ?? nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            if let actionTitle = actiontitle , let actionClosure = action {
                let confirmAction = UIAlertAction(title: actionTitle, style: .default, handler: actionClosure)
                alertController.addAction(confirmAction)
            }
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
