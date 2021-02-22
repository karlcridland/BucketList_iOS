//
//  Date.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation

extension Date{
    
    func string() -> String{
        let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]

        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd"
        let day = Int(formatter.string(from: self))!
        formatter.dateFormat = "MM"
        let month = Int(formatter.string(from: self))!
        formatter.dateFormat = "yyyy"
        let year = Int(formatter.string(from: self))!
        
        return "\(day.ordinate()) \(months[month-1]) \(year)"
    }
}
