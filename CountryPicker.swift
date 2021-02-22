//
//  CountryPicker.swift
//  bucket list
//
//  Created by Karl Cridland on 09/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class CountryPicker: UIScrollView{
    
    var picked = -1
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        filter("")
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func filter(_ by: String){
        removeAll()
        picked = -1
        var i = 0
        for country in Countries.all.countries{
            if (by.count == 0) || (country.name.lowercased().contains(by.lowercased())){
                let background = UIView(frame: CGRect(x: 0, y: CGFloat(i)*40, width: frame.width, height: 40))
                let c = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: background.frame.height))
                let t = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: background.frame.height))
                background.addSubview(t)
                background.addSubview(c)
                background.backgroundColor = .white
                c.addTarget(self, action: #selector(pick), for: .touchUpInside)
                t.text = "     \(country.flag)   \(country.name)"
                t.textAlignment = .left
                t.textColor = .black
                c.tag = Countries.all.get(country.name)
                addSubview(background)
                i += 1
            }
        }
        contentSize = CGSize(width: frame.width, height: CGFloat(i*40))
    }
    
    @objc func pick(_ sender: UIButton){
        for subview in subviews{
            subview.backgroundColor = .white
        }
        sender.superview!.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        picked = sender.tag
    }
    
    func get() -> Int{
        return picked
    }
}
