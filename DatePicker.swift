//
//  DatePicker.swift
//  bucket list
//
//  Created by Karl Cridland on 09/05/2020.
//  Copyright © 2020 Karl Cridland. All rights reserved.
//

import Foundation
import UIKit

class DatePicker: UIView, UIScrollViewDelegate{
    
    let day = DPScrollView(), month = DPScrollView(), year = DPScrollView()
    
    private let dates = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for form in [day,month,year]{
            addSubview(form)
            form.showsVerticalScrollIndicator = false
            form.delegate = self
            backgroundColor = .white
            scrollViewDidEndDragging(form, willDecelerate: false)
            scrollViewDidEndDecelerating(form)
            form.layer.cornerRadius = 4
        }
        
        let sepA = UILabel(frame: CGRect(x: 2*frame.width/10, y: 0, width: frame.width/10, height: frame.height))
        let sepB = UILabel(frame: CGRect(x: 5*frame.width/10, y: 0, width: frame.width/10, height: frame.height))
        for sep in [sepA,sepB]{
            addSubview(sep)
            sep.text = "/"
            sep.textAlignment = .center
            sep.textColor = .black
        }
        
        day.frame = CGRect(x: 0, y: 0, width: 2*frame.width/10, height: frame.height)
        month.frame = CGRect(x: 3*frame.width/10, y: 0, width: 2*frame.width/10, height: frame.height)
        year.frame = CGRect(x: 6*frame.width/10, y: 0, width: 4*frame.width/10, height: frame.height)
        
        structure()
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        (scrollView as! DPScrollView).stopped = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (!scrollView.isDragging){
            scrollOver(scrollView)
            (scrollView as! DPScrollView).stopped = true
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollOver(scrollView)
        (scrollView as! DPScrollView).stopped = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor = .white
        scrollView.isPagingEnabled = false
        if (!scrollView.isDragging ){
            scrollOver(scrollView)
        }
        (scrollView as! DPScrollView).stopped = false
    }
    
    func ready() -> Bool{
        var r = 0
        for s in [day,month,year]{
            if s.stopped{
                r += 1
            }
        }
        return r == 3
    }
    
    func scrollOver(_ scrollView: UIScrollView){
        var offset = Int(scrollView.contentOffset.y)/Int(frame.height)*Int(frame.height)
        if Int(scrollView.contentOffset.y)%Int(frame.height) >= Int(frame.height)/2{
            offset += Int(frame.height)
        }
        scrollView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2, animations: {
            scrollView.contentOffset = CGPoint(x: 0, y: offset)
            scrollView.isUserInteractionEnabled = true
            self.structure()
        })
    }
    
    @objc func structure(){
        let y = Int(Calendar.current.component(.year, from: Date()))
        var i = 0
        let y1 = UILabel(frame: CGRect(x: 0, y: CGFloat(0)*frame.height, width: 4*frame.width/10, height: frame.height))
        y1.text = "YYYY"
        y1.textColor = .black
        y1.textAlignment = .center
        year.addSubview(y1)
        while (y-i > 1900){
            let p = UILabel(frame: CGRect(x: 0, y: CGFloat(i+1)*frame.height, width: 4*frame.width/10, height: frame.height))
            p.textColor = .black
            p.text = String(y-i)
            p.textAlignment = .center
            year.addSubview(p)
            i += 1
        }
        year.contentSize = CGSize(width: CGFloat(4)*frame.width/10, height: CGFloat(i+1)*frame.height)
        i = 0
        let M1 = UILabel(frame: CGRect(x: 0, y: CGFloat(0)*frame.height, width: 2*frame.width/10, height: frame.height))
        M1.text = "MM"
        M1.textColor = .black
        M1.textAlignment = .center
        month.addSubview(M1)
        while i < 12{
            let p = UILabel(frame: CGRect(x: 0, y: CGFloat(i+1)*frame.height, width: 2*frame.width/10, height: frame.height))
            p.text = String(i+1)
            p.textColor = .black
            p.textAlignment = .center
            month.addSubview(p)
            i += 1
        }
        month.contentSize = CGSize(width: CGFloat(2)*frame.width/10, height: CGFloat(13)*frame.height)
        i = 0
        let d1 = UILabel(frame: CGRect(x: 0, y: CGFloat(0)*frame.height, width: 2*frame.width/10, height: frame.height))

        d1.textColor = .black
        d1.text = "DD"
        d1.textAlignment = .center
        day.addSubview(d1)
        while (i < 31){
            let p = UILabel(frame: CGRect(x: 0, y: CGFloat(i+1)*frame.height, width: 2*frame.width/10, height: frame.height))
            p.text = String(i+1)
            p.textColor = .black
            p.textAlignment = .center
            day.addSubview(p)
            i += 1
        }
        if (getMonth() == 2 && getYear().isLeapYear()){
            day.contentSize = CGSize(width: 2*frame.width/10, height: 30*frame.height)
        }
        else{
            if getMonth() == 0{
                day.contentSize = CGSize(width: 2*frame.width/10, height: CGFloat(32)*frame.height)
            }
            else{
                if getMonth() > 12{
                    day.contentSize = CGSize(width: 2*frame.width/10, height: CGFloat(dates[11]+1)*frame.height)
                }else{
                    day.contentSize = CGSize(width: 2*frame.width/10, height: CGFloat(dates[getMonth()-1]+1)*frame.height)
                }
            }
        }
    }
    
    
    
    func datePicked() -> Bool{
        if (day.contentOffset.y == 0 || month.contentOffset.y == 0 || year.contentOffset.y == 0){
            for a in [day,month,year]{
                a.backgroundColor = .white
                if (a.contentOffset.y == 0){
                    a.backgroundColor = #colorLiteral(red: 1, green: 0.9089738131, blue: 0.9363365769, alpha: 1)
                }
            }
            return false
        }
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDay() -> Int{
        return Int(day.contentOffset.y/frame.height)
    }
    
    func getMonth() -> Int{
        return Int(0.499+month.contentOffset.y/frame.height)
    }
    
    func getYear() -> Int{
        return 1 + Int(Calendar.current.component(.year, from: Date())) - Int(0.499+year.contentOffset.y/frame.height)
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }
}

class DPScrollView: UIScrollView{
    
    var stopped = true
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
