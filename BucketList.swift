//
//  BucketList.swift
//  bucket list
//
//  Created by Karl Cridland on 07/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation

class BucketList {
    
    public static let shared = BucketList()
    private let defaults = UserDefaults.standard
    
    private init(){
        
    }
    
    func okey() -> [String]{
        if defaults.value(forKey: "key") != nil{
            return defaults.value(forKey: "key") as! [String]
        }
        return []
    }
    
    func store(_ objectives: [Objective]){
        var key = [String]()
        var i = 0
        for objective in objectives{
            key.append(String(i))
            var new = [String:Any]()
            new["objective"] = objective.objective
            new["complete"] = objective.complete
            new["country"] = objective.country
            new["date"] = objective.date
            defaults.set(new, forKey: String(i))
            i += 1
        }
        defaults.set(key, forKey: "key")
    }
    
    func get() -> [Objective]{
        var all = [Objective]()
        for k in okey(){
            if let g = defaults.value(forKey: k) as? [String:Any]{
                let new = Objective(objective: g["objective"] as! String, country: g["country"] as! Int, key: k)
                if let complete = g["complete"] as? Bool{
                    new.complete = complete
                    new.date = g["date"] as! Date
                }
                all.append(new)
            }
        }
        return all
    }
    
    func append(_ objective: Objective){
        var a = get()
        a.append(objective)
        store(a)
    }
    
    func removeAll(){
        for a in okey(){
            defaults.set(nil, forKey: a)
        }
        defaults.set(nil, forKey: "key")
    }
    
}


