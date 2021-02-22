//
//  Page.swift
//  bucket list
//
//  Created by Karl Cridland on 09/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class Page: UIView {
    
    let background = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let title = UILabel()
    let ok = UIButton(), cancel = UIButton()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        clipsToBounds = true
        alpha = 0.0
        self.background.backgroundColor = .clear
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {_ in
            if self.superview != nil{
                self.superview!.addSubview(self.background)
                self.superview!.bringSubviewToFront(self)
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.background.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.2989619006)
                        self.transform = CGAffineTransform.identity
                        self.alpha = 1.0
                    })
                })
            }
        })
        background.addTarget(self, action: #selector(remove), for: .touchUpInside)
        
        backgroundColor = .white
        layer.cornerRadius = 8.0
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.borderWidth = 2.0
        title.frame = CGRect(x: 0, y: 0, width: frame.width, height: 60)
        title.textColor = .black
        title.textAlignment = .center
        addSubview(title)
        cancel.addTarget(self, action: #selector(remove), for: .touchUpInside)
    }
    
    @objc func submit(){
        
    }
    
    @objc func remove(){
        removeFromSuperview()
    }
    
    override func removeFromSuperview() {
        alpha = 1.0
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.background.backgroundColor = .clear
            self.alpha = 0.0
        })
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
            super.removeFromSuperview()
            self.background.removeFromSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
