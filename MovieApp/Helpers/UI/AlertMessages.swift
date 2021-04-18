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
    
    
    
}
