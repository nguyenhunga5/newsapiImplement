//
//  UIViewExt.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/25/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit

extension UIView {
    func shake(duration timeDuration: Double = 0.07, repeat countRepeat: Float = 3){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = timeDuration
        animation.repeatCount = countRepeat
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}
