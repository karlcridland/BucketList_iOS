//
//  ObjectivePage.swift
//  bucket list
//
//  Created by Karl Cridland on 09/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class ObjectivePage: Page {
    
    private var cp = CountryPicker()
    private var objective = UITextField()
    private let display: Display
    
    init(_ display: Display) {
        self.display = display
        super .init(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width-40, height: 350))
        
        cancel.frame = CGRect(x: 0, y: 300, width: (UIScreen.main.bounds.width-40)/2+1, height: 50)
        cancel.setTitle("cancel", for: .normal)
        ok.frame = CGRect(x: (UIScreen.main.bounds.width-40)/2-1, y: 300, width: (UIScreen.main.bounds.width-40)/2+1, height: 50)
        ok.setTitle("confirm", for: .normal)
        ok.addTarget(self, action: #selector(submit), for: .touchUpInside)
        title.text = "new list item"
        for button in [ok,cancel]{
            addSubview(button)
            button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            button.layer.borderWidth = self.layer.borderWidth
            button.layer.cornerRadius = 0
        }

        cp = CountryPicker(frame: CGRect(x: 0, y: 138, width: UIScreen.main.bounds.width-40, height: 162))
        
        let sb = UIView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width-40, height: 40))
        sb.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        sb.layer.borderWidth = self.layer.borderWidth
        addSubview(sb)
        let sb2 = UIView(frame: CGRect(x: 0, y: 98, width: UIScreen.main.bounds.width-40, height: 40))
        sb2.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        sb2.layer.borderWidth = self.layer.borderWidth
        addSubview(sb2)
        objective = UITextField(frame: CGRect(x: 20, y: 62, width: UIScreen.main.bounds.width-80, height: 40))
        objective.addTarget(self, action: #selector(empty), for: .allEditingEvents)
        objective.addTarget(self, action: #selector(clicked), for: .editingDidBegin)
        objective.accessibilityElements = [cp]
        objective.textColor = .black
        objective.text = "Title"
        objective.accessibilityLabel = "Title"
        objective.textColor = .black
        objective.returnKeyType = UIReturnKeyType(rawValue: 9)!
        addSubview(objective)
        let search = UITextField(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width-80, height: 40))
        search.addTarget(self, action: #selector(empty), for: .allEditingEvents)
        search.addTarget(self, action: #selector(filter), for: .editingChanged)
        search.addTarget(self, action: #selector(clicked), for: .editingDidBegin)
        search.accessibilityElements = [cp]
        search.textColor = .black
        search.text = "Search"
        search.accessibilityLabel = "Search"
        search.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        search.returnKeyType = UIReturnKeyType(rawValue: 9)!
        addSubview(search)
        addSubview(cp)
        objective.becomeFirstResponder()
    }
    
    @objc func clicked(sender: UITextField){
        if sender.text! == sender.accessibilityLabel!{
            sender.text = ""
        }
    }
    
    @objc func empty(sender: UITextField){
        if (sender.text?.count == 0) && !(sender.isEditing){
            sender.text = sender.accessibilityLabel!
        }
    }
    
    @objc override func submit() {
        if ((cp.get() >= 0) && (objective.text!.count != 0)){
            let new = Objective(objective: objective.text!, country: cp.get(), key: "")
            print(cp.get())
            BucketList.shared.append(new)
            display.objects.append(new.display(display))
            remove()
            display.update()
        }
    }
    
    @objc func filter(_ sender: UITextField){
        let cp = sender.accessibilityElements![0] as! CountryPicker
        cp.filter(sender.text!)
    }
    
    @objc func resign(){
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
