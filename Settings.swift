//
//  Settings.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class Settings{
    
    var upper_bound = CGFloat(0.0)
    var lower_bound = CGFloat(0.0)
    
    enum Background{
        case Iceland, Cambodia
    }
    
    public static let shared = Settings()
    
    private init(){
        
    }
    
    
}
