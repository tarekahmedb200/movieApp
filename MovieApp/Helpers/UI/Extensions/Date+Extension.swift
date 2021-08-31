//
//  Date+Extension.swift
//  MovieApp
//
//  Created by lapshop on 5/30/21.
//

import Foundation
import UIKit



extension Date {
    
    static func  getTimeComponents(with interval:Int) -> String? {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second]
        formatter.unitsStyle = .positional
        
        guard  let dateString = formatter.string(from: TimeInterval(interval)) else {
            return nil
        }
        
        return dateString
    }
    
    
}
