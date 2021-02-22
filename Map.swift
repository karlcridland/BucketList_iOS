//
//  Map.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class Map: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    func update(_ countries: [Int]){
        removeAll()
        var countries2:[Int] = []
        for c in countries{
            if !countries2.contains(c){
                countries2.append(c)
            }
        }
        let base = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        base.image = UIImage(named: "world map")
        base.contentMode = .scaleAspectFit
        addSubview(base)
        for i in countries2{
            let country = Countries.all.get(i).name.lowercased()
            let image = UIImageView(frame: base.frame)
            image.image = UIImage(named: country)
            image.contentMode = .scaleAspectFit
            addSubview(image)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
