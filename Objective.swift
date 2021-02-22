//
//  Objective.swift
//  bucket list
//
//  Created by Karl Cridland on 07/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class Objective {
    
    var objective: String
    var country: Int
    var key: String
    var complete = false
    var date: Date
    
    init(objective: String, country: Int, key: String) {
        self.objective = objective
        self.country = country
        self.key = key
        self.date = Date()
    }
    
    func encode() -> obj{
        return obj(objective: objective, country: country, key: key, complete: complete)
    }
    
    func display(_ d: Display) -> ObjectiveDisplay{
        return ObjectiveDisplay(objective: self, display: d)
    }
    
}

class ObjectiveDisplay: UIView{
    
    let objective: Objective
    var isTracking = false
    var placed = true
    private var sub = UILabel()
    let display: Display
    
    init(objective: Objective, display: Display) {
        self.objective = objective
        self.display = display
        super .init(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width-20, height: 50))
        layer.cornerRadius = 6
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 2.0
        backgroundColor = .white
        clipsToBounds = true
        update()
    }
    
    func update(){
        removeAll()
        let flag = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        flag.text = Countries.all.get(objective.country).flag
        flag.textAlignment = .center
        addSubview(flag)
        let title = UILabel(frame: CGRect(x: 50, y: 0, width: frame.width-20, height: frame.height/2+5))
        title.text = objective.objective
        title.textColor = .black
        title.font = .systemFont(ofSize: 13)
        addSubview(title)
        sub = UILabel(frame: CGRect(x: 50, y: frame.height/2-5, width: frame.width-20, height: frame.height/2+5))
        sub.font = .systemFont(ofSize: 13)
        sub.textColor = .black
        addSubview(sub)
        if objective.complete{
            sub.text = objective.date.string()
            backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
        else{
            backgroundColor = .white
            sub.text = "swipe to mark complete"
            sub.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            let swipe = UIView(frame: CGRect(x: frame.width-47, y: 3, width: 44, height: 44))
            swipe.layer.cornerRadius = layer.cornerRadius - 1
            swipe.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            swipe.layer.borderWidth = 1.0
            swipe.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).withAlphaComponent(0.4)
            addSubview(swipe)
            swipe.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(move)))
        }
    }
    
    @objc func move(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: self)
        let frame = gesture.view!
        display.delete.removeFromSuperview()
        frame.center = CGPoint(x: frame.center.x + translation.x, y: frame.center.y)
        if (frame.center.x > self.frame.width-24){
            frame.center = CGPoint(x: self.frame.width-24, y: frame.center.y)
        }
        else{
            let a = 2*(self.frame.width-24-frame.center.x)
            if (a > 0){
                frame.frame = CGRect(x: frame.frame.minX, y: 0, width: self.frame.width-frame.frame.minX, height: 50)
            }
            else{
                frame.frame = CGRect(x: frame.frame.minX, y: frame.frame.minY, width: CGFloat(46), height: frame.frame.height)
            }
        }
        gesture.setTranslation(CGPoint.zero, in: self)
        if (gesture.state == .ended){
            if (frame.frame.minX < self.frame.width/3){
                UIView.animate(withDuration: 0.1, animations: {
                    frame.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                })
                homeView().addSubview(DatePage(objective: self))
            }
            else{
                UIView.animate(withDuration: 0.1, animations: {
                    frame.frame = CGRect(x: self.frame.width-47, y: 3, width: 44, height: 44)
                })
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct obj: Encodable{
    var objective: String
    var country: Int
    var key: String
    var complete = false
}
