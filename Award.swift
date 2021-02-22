//
//  Award.swift
//  bucket list
//
//  Created by Karl Cridland on 09/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class Award {
    
    let title: String
    let description: String
    let display = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
    let button = UIButton()
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
        let image = UIImageView(frame: CGRect(x: 10, y: 20, width: 80, height: 80))
        image.image = UIImage(named: title.lowercased())
        image.contentMode = .scaleAspectFit
        display.addSubview(image)
        let label = UILabel(frame: CGRect(x: 5, y: 90, width: display.frame.width-10, height: 30))
        label.numberOfLines = 0
        label.text = title
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .black
        display.addSubview(label)
        
        display.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        display.layer.borderWidth = 1.0
        display.layer.cornerRadius = 4.0
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 120)
        display.addSubview(button)
    }
}
