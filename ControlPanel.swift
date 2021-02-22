//
//  ControlPanel.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class ControlPanel: UIView {
    
    let map = Map(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 250))
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(map)
        let display = Display(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-200-Settings.shared.lower_bound), map: map)
        
        addSubview(display)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
