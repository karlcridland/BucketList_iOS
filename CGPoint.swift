//
//  CGPoint.swift
//  bucket list
//
//  Created by Karl Cridland on 08/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint{
    
    func distance(_ point: CGPoint) -> CGFloat{
        let minX = [point.x,self.x].min()!
        let minY = [point.y,self.y].min()!
        let width = (point.x-minX) + (self.x-minX)
        let height = (point.y-minY) + (self.y-minY)
        return ((width * width) + (height * height)).squareRoot()
    }
}
