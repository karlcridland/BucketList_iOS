//
//  Int.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation

extension Int{
    
    func ordinate() -> String{
        if (self%100 >= 11) && (self%100 <= 13){
            return String(self)+"th"
        }
        else{
            switch self%10 {
            case 1:
                return String(self)+"st"
            case 2:
                return String(self)+"nd"
            case 3:
                return String(self)+"rd"
            default:
                return String(self)+"th"
            }
        }
    }
    
    func isLeapYear() -> Bool{
        if self % 4 == 0 {
            if self % 100 == 0 && self % 400 != 0 {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
}
