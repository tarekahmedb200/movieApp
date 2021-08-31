//
//  ViewController+Extensions.swift
//  MovieApp
//
//  Created by lapshop on 8/30/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        
        
        AlertMessages.shared.showMessage(title: "logout", message: "Are you sure you want to logout", in: self, with: "yes") {_ in 
            LoginService.logout { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }else {
                    print(error)
                }
            }
        }
        
        
        
        
        
        
    }

}
