//
//  UIView.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func removeAll(){
        for subview in subviews{
            subview.removeFromSuperview()
        }
    }
    
    func inside(_ point: CGPoint) -> Bool{
//        return ((point.x >= self.frame.minX) && (point.x <= self.frame.maxX)) && ((point.y >= self.frame.minY) && (point.y <= self.frame.maxY))
        return ((point.y >= self.frame.minY) && (point.y <= self.frame.maxY))
    }
    
    func inside(_ view: UIView) -> Bool{
        for point in view.corners(){
            if (((point.x >= self.frame.minX) && (point.x <= self.frame.maxX)) && ((point.y >= self.frame.minY) && (point.y <= self.frame.maxY))){
                return true
            }
        }
        return false
    }
    
    
    
    func corners() -> [CGPoint]{
        return [CGPoint(x: frame.minX, y: frame.minY), CGPoint(x: frame.minX, y: frame.maxY), CGPoint(x: frame.maxX, y: frame.minY), CGPoint(x: frame.maxX, y: frame.maxY)]
    }
    
    func homeView() -> UIView{
        if superview != nil{
            if self.tag == 69{
                return self
            }
            return superview!.homeView()
        }
        else{
            return self
        }
    }
    
}
