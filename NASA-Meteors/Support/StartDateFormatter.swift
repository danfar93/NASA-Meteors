//
//  StartDateFormatter.swift
//  NASA-Meteors
//
//  Created by Daniel Farrell on 02/03/2020.
//  Copyright © 2020 Daniel Farrell. All rights reserved.
//

import Foundation

class StartDateFormatter {
    
    
    /*
     * Formats date we want to compare to
     * to determine if meteor fell after 1900
     */
    func formatDate() -> Date {
        
        let dateString = "01/01/1900"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let startDate = dateFormatter.date(from: dateString)!
        
        return startDate
    }
    
    
}
