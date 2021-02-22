//
//  StatsPage.swift
//  bucket list
//
//  Created by Karl Cridland on 09/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class StatsPage: Page {
    
    private var cp = CountryPicker()
    private var objective = UITextField()
    private let display: Display
    private let scroll = UIScrollView()
    private let desc = UILabel()
    
    init(_ display: Display) {
        self.display = display
        super .init(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width-40, height: 380))
        title.text = "Statistics"
        scroll.frame = CGRect(x: 0, y: 170, width: frame.width+40, height: 120)
        cancel.frame = CGRect(x: 0, y: 330, width: frame.width+40, height: 50)
        cancel.setTitle("close", for: .normal)
        cancel.setTitleColor(.black, for: .normal)
        
        let a = Statistic(frame: CGRect(x: 0, y: 60, width: scroll.frame.width, height: 20), title: "Countries visited:", value: String(countrysVisited()))
        let b = Statistic(frame: CGRect(x: 0, y: 80, width: scroll.frame.width, height: 20), title: "Continents visited:", value: "\(continentsVisited())")
        let m = mostRecent()
        var c = Statistic(frame: CGRect(x: 0, y: 100, width: scroll.frame.width, height: 20), title: "Most recent:", value: "")
        if m >= 0{
            c = Statistic(frame: CGRect(x: 0, y: 100, width: scroll.frame.width, height: 20), title: "Most recent:", value: String(Countries.all.get(m).name))
        }
        else{
        }
        let ach = UILabel(frame: CGRect(x: 0, y: 120, width: frame.width+40, height: 40))
        ach.text = "Achievements"
        ach.textColor = .black
        ach.textAlignment = .center
        addSubview(ach)
        
        for a in [a,b,c,scroll,cancel]{
            addSubview(a)
        }
        var i = 0
        for a in awards(){
            a.display.frame = CGRect(x: 10 + CGFloat(i)*110, y: 0, width: 100, height: 120)
            scroll.addSubview(a.display)
            a.button.addTarget(self, action: #selector(describe), for: .touchUpInside)
            a.button.accessibilityElements = [a]
            i += 1
        }
        scroll.contentSize = CGSize(width: 20 + CGFloat(i)*110, height: 120)
        desc.textColor = .black
        desc.frame = CGRect(x: 0, y: 290, width: frame.width+40, height: 40)
        desc.textAlignment = .center
        desc.font = .systemFont(ofSize: 14)
        addSubview(desc)
    }
    
    @objc func describe(sender: UIButton){
        let award = sender.accessibilityElements![0] as! Award
        desc.text = award.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func countrysVisited() -> Int{
        var i = [Int]()
        for item in display.objects{
            if item.objective.complete{
                if !i.contains(item.objective.country){
                    i.append(item.objective.country)
                }
            }
        }
        return i.count
    }
    
    func continentsVisited() -> Int{
        var i = [Int]()
        for item in display.objects{
            if item.objective.complete{
                let c = Countries.all.get(item.objective.country).continent
                if !i.contains(c){
                    i.append(c)
                }
            }
        }
        return i.count
    }
    
    func mostRecent() -> Int{
        var i: Objective?
        for item in display.objects{
            if item.objective.complete{
                if i != nil{
                    if item.objective.date > i!.date{
                        i = item.objective
                    }
                }
                else{
                    i = item.objective
                }
            }
        }
        if i != nil{
            return i!.country
        }
        return -1
    }
    
    func complete() -> [Objective]{
        var c = [Objective]()
        for item in display.objects{
            if item.objective.complete{
                c.append(item.objective)
            }
        }
        return c
    }
    
    func awards() -> [Award]{
        let c = complete()
        var a = [Award]()
        if c.count >= 1{
            a.append(Award(title: "Beginner", description: "Earned one award"))
        }
        if c.count >= 5{
            a.append(Award(title: "Tourist", description: "Earned five awards"))
        }
        if c.count >= 10{
            a.append(Award(title: "Traveller", description: "Earned ten awards"))
        }
        if c.count >= 20{
            a.append(Award(title: "Globe Trotter", description: "Earned twenty awards"))
        }
        if c.count >= 50{
            a.append(Award(title: "Over Achiever", description: "Earned fifty awards"))
        }
        if viking(){
            a.append(Award(title: "Viking", description: "Visited every Scandanavian country"))
        }
        if climber(){
            a.append(Award(title: "Peak Activity", description: "Climb a big mountain"))
        }
        if worldwide(){
            a.append(Award(title: "Mr. Worldwide", description: "Visit every continent"))
        }
        if a.count == 8{
            a.append(Award(title: "Show Off", description: "Unlocked every achievement"))
        }
        return a
    }
    
    func worldwide() -> Bool{
        var continents = [Int]()
        for item in display.objects{
            if item.objective.complete{
                let c = Countries.all.get(item.objective.country).continent
                if !continents.contains(c){
                    continents.append(c)
                }
            }
        }
        return continents.count == 6
    }
    
    func viking() -> Bool{
        var codes = [Int]()
        for a in complete(){
            codes.append(a.country)
        }
        return codes.contains(10) && codes.contains(50) && codes.contains(22) && codes.contains(38) && codes.contains(14)
    }
    
    func climber() -> Bool{
        for item in display.objects{
            if item.objective.complete{
                if ((item.objective.country == 153) && (item.objective.objective.contains("mountain") || item.objective.objective.contains("kilimanjaro"))){
                    return true
                }
                if ((item.objective.country == 85) && (item.objective.objective.contains("mountain") || item.objective.objective.contains("everest"))){
                    return true
                }
            }
        }
        return false
    }
}

class Statistic: UIView {
    init(frame: CGRect, title: String, value: String) {
        super .init(frame: frame)
        let a = UILabel(frame: CGRect(x: 20, y: 0, width: frame.width-40, height: frame.height))
        a.text = title
        a.textColor = .black
        addSubview(a)
        let b = UILabel(frame: CGRect(x: 20, y: 0, width: frame.width-40, height: frame.height))
        b.text = value
        b.textAlignment = .right
        b.textColor = .black
        addSubview(b)
        
        for a in [a,b]{
            a.font = .systemFont(ofSize: 14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
