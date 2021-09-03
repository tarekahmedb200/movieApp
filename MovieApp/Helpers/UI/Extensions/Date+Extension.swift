//
//  Date+Extension.swift
//  MovieApp
//
//  Created by lapshop on 5/30/21.
//

import Foundation
import UIKit



extension Date {
    
    
    static  func minutesToHoursMinutes (minutes : Int) -> (hours:Int, minutes:Int) {
      return (minutes / 60, minutes % 60)
    }
    
    
    
    static func  getTimeComponents(with interval:Int64) -> String? {
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour,.minute,.second]
        formatter.unitsStyle = .short
        
        guard  let dateString = formatter.string(from: TimeInterval(interval)) else {
            return nil
        }
        
        return dateString
    }
    
    
}
