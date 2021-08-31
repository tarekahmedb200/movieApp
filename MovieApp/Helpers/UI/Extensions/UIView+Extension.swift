//
//  UIView+Extension.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation
import UIKit

extension UIView {
    
    func addRadius(by radius: CGFloat)   {
        self.layer.cornerRadius = radius
    }
    
    func loadFromNib<T:UIView>() -> T?{
        guard let nibFile = Bundle.main.loadNibNamed(String(describing:type(of: self)), owner: self, options:nil)?[0] , let customView = nibFile as? T  else {
            return nil
        }
        return customView
    }
    

}
