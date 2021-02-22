//
//  DatePage.swift
//  bucket list
//
//  Created by Karl Cridland on 09/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class DatePage: Page {
    
    private let objective: ObjectiveDisplay
    let dp = DatePicker(frame: CGRect(x: 20, y: 70, width: UIScreen.main.bounds.width-80, height: 60))
    
    init(objective: ObjectiveDisplay) {
        self.objective = objective
        super .init(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width-40, height: 200))
        title.text = "When did you complete this?"
        addSubview(dp)
        cancel.frame = CGRect(x: 0, y: 150, width: (UIScreen.main.bounds.width-40)/2+1, height: 50)
        cancel.setTitle("cancel", for: .normal)
        ok.frame = CGRect(x: (UIScreen.main.bounds.width-40)/2-1, y: 150, width: (UIScreen.main.bounds.width-40)/2+1, height: 50)
        ok.setTitle("confirm", for: .normal)
        ok.addTarget(self, action: #selector(submit), for: .touchUpInside)
        for button in [ok,cancel]{
            addSubview(button)
            button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            button.layer.borderWidth = self.layer.borderWidth
            button.layer.cornerRadius = 0
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        objective.update()
    }
    
    @objc override func submit(){
        if dp.datePicked(){
            if dp.ready(){
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let new = formatter.date(from: "\(dp.getDay())/\(dp.getMonth())/\(dp.getYear())")
                objective.objective.complete = true
                objective.objective.date = new!
                removeFromSuperview()
                objective.update()
                objective.display.updateMap()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
