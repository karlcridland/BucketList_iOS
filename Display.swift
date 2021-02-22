//
//  Display.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class Display: UIScrollView, UIScrollViewDelegate {
    
    var touched = false
    var held = false
    var position = CGPoint()
    var highlighted = UIView()
    var difX = CGFloat()
    var difY = CGFloat()
    var shadows = [Shadow]()
    var objects = [ObjectiveDisplay]()
    let map: Map
    
    var delete = Delete(frame: CGRect(x: UIScreen.main.bounds.width/2-30, y: 40, width: 60, height: 60))
    var deleteConfirm = false
    
    init(frame: CGRect, map: Map) {
        self.map = map
        super .init(frame: frame)
        delegate = self
        clipsToBounds = false
        update()
        delete.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.4)
        delete.layer.cornerRadius = 30
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { _ in
            BucketList.shared.store(self.newOrder())
        })
    }
    
    func update(){
        removeAll()
        shadows.removeAll()
        objects.removeAll()
        let stats = UIButton(frame: CGRect(x: 10, y: 200, width: UIScreen.main.bounds.width/2-15, height: 40))
        stats.backgroundColor = .white
        stats.layer.cornerRadius = 5.0
        stats.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        stats.layer.borderWidth = 2.0
        stats.setTitle("statistics", for: .normal)
        stats.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        addSubview(stats)
        stats.addTarget(self, action: #selector(openStats), for: .touchUpInside)
        let new = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/2+5, y: 200, width: UIScreen.main.bounds.width/2-15, height: 40))
        new.backgroundColor = .white
        new.layer.cornerRadius = 5.0
        new.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        new.layer.borderWidth = 2.0
        new.setTitle("add", for: .normal)
        new.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        addSubview(new)
        new.addTarget(self, action: #selector(newObjective), for: .touchUpInside)
        var i = 0
        for objective in BucketList.shared.get(){
            let obj = objective.display(self)
            obj.frame = CGRect(x: obj.frame.minX, y: CGFloat(70*i)+260, width: obj.frame.width, height: obj.frame.height)
            obj.tag = i
            objects.append(obj)
            
            let shadow = Shadow(obj)
            shadow.frame = obj.frame
            addSubview(shadow)
            shadows.append(shadow)
            shadow.tag = i
            
            addSubview(obj)
            i += 1
        }
        contentSize = CGSize(width: frame.width, height: CGFloat(70*i) + 240)
        updateMap()
    }
    
    @objc func openStats(){
        homeView().addSubview(StatsPage(self))
    }
    
    @objc func newObjective(){
        homeView().addSubview(ObjectivePage(self))
    }
    
    func updateMap(){
        var c:[Int] = []
        for o in objects{
            if o.objective.complete{
                c.append(o.objective.country)
            }
        }
        map.update(c)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        reset()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        reset()
        delete.removeFromSuperview()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        reset()
    }
    
    func reset(){
        position = CGPoint()
        highlighted = UIView()
        difX = CGFloat()
        difY = CGFloat()
        for object in objects{
            object.transform = CGAffineTransform.identity
            if object.gestureRecognizers != nil{
                for gesture in object.gestureRecognizers!{
                    object.removeGestureRecognizer(gesture)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched = true
        let touch = touches.first!
        position = touch.location(in: self)
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            if !self.touched{
                timer.invalidate()
            }
            if i == 20{
                self.held = true
                timer.invalidate()
                for subview in self.subviews{
                    if (((subview.inside(touch.location(in: self))) && (subview is ObjectiveDisplay)) && (self.position.x < self.frame.width-60)){
                        self.homeView().addSubview(self.delete)
                        self.delete.jumpIn()
                        UIView.animate(withDuration: 0.1, animations: {
                            self.highlighted = subview
                            self.difX = self.highlighted.center.x - self.position.x
                            self.difY = self.highlighted.center.y - self.position.y
                            subview.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                            let offset = self.contentOffset
                            self.isScrollEnabled = false
                            self.contentOffset = offset
                            for s in self.subviews{
                                if s is ObjectiveDisplay{
                                    self.bringSubviewToFront(s)
                                }
                            }
                            self.bringSubviewToFront(subview)
                            (subview as! ObjectiveDisplay).isTracking = true
                        })
                    }
                }
            }
            i += 1
        })
        for o in objects{
            if !o.isTracking{
                o.transform = CGAffineTransform.identity
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let delLoc = touch.location(in: homeView())
        highlighted.center = CGPoint(x: location.x + difX, y: location.y + difY)
        arrange()
        if delLoc.distance(delete.center) < 30{
            deleteConfirm = true
            UIView.animate(withDuration: 0.1, animations: {
                self.delete.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        else{
            deleteConfirm = false
            UIView.animate(withDuration: 0.1, animations: {
                self.delete.transform = CGAffineTransform.identity
            })
        }
    }
    
    func arrange(){
        for shadow in shadows{
            if highlighted.inside(shadow.center){
                for s in shadows{
                    if s.objective.tag == highlighted.tag{
                        s.objective = shadow.objective
                    }
                }
                if highlighted is ObjectiveDisplay{
                    shadow.objective = highlighted as! ObjectiveDisplay
                }
            }
        }
        for shadow in shadows{
            if !shadow.objective.isTracking{
                UIView.animate(withDuration: 0.1, animations: {
                    shadow.objective.center = shadow.center
                })
            }
        }
        
    }
    
    func deleteItem(){
        var y = CGFloat()
        var i = 0
        for shadow in shadows{
            if shadow.objective.tag == highlighted.tag{
                y = shadow.center.y
                shadow.removeFromSuperview()
                shadows.remove(at: i)
            }
            i += 1
        }
        i = 0
        for object in objects{
            if object.tag == highlighted.tag{
                object.removeFromSuperview()
                objects.remove(at: i)
            }
            i += 1
        }
        for s in subviews{
            if s.center.y > y{
                UIView.animate(withDuration: 0.1, animations: {
                    s.center = CGPoint(x: s.center.x, y: s.center.y-70)
                })
            }
        }
        contentSize = CGSize(width: contentSize.width, height: contentSize.height-70)
        updateMap()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if deleteConfirm{
            deleteConfirm = false
            deleteItem()
        }
        delete.removeFromSuperview()
        touched = false
        held = false
        self.isScrollEnabled = true
        for subview in subviews{
            if subview.gestureRecognizers != nil{
                for gesture in subview.gestureRecognizers!{
                    subview.removeGestureRecognizer(gesture)
                }
            }
            if subview.transform != CGAffineTransform.identity{
                subview.transform = CGAffineTransform.identity
            }
            if subview is ObjectiveDisplay{
                (subview as! ObjectiveDisplay).isTracking = false
            }
        }
        arrange()
        BucketList.shared.store(self.newOrder())
        reset()
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            if !self.touched{
                self.reset()
            }
            if i == 10{
                BucketList.shared.store(self.newOrder())
                timer.invalidate()
            }
            i += 1
        })
    }
    
    private func newOrder() -> [Objective]{
        var objectives = [Objective]()
        for shadow in shadows{
            objectives.append(shadow.objective.objective)
        }
        return objectives
    }

}

class Shadow: UIView {
    
    var covered = true
    var objective: ObjectiveDisplay
    
    init(_ objective: ObjectiveDisplay) {
        self.objective = objective
        super .init(frame: objective.frame)
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).withAlphaComponent(0.4)
        layer.cornerRadius = objective.layer.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Delete: UIView{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        image.image = UIImage(named: "bin")
        addSubview(image)
        image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    func jumpIn(){
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    override func removeFromSuperview() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        })
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { _ in
            super.removeFromSuperview()
            self.transform = CGAffineTransform.identity
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
