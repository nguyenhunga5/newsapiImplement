//
//  UIViewExReuseable.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit

protocol ReuseableCell: NSObject {
    static var identifier: String {get}
    static var nib: UINib? {get}
}

extension ReuseableCell {
    static var identifier: String {
        let className = NSStringFromClass(self.classForCoder())
        guard let name = className.split(separator: ".").last else {return className}
        return String(name)
    }
    
    static var nib: UINib? {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}

extension UIView: ReuseableCell {}

extension UIView {
    func findParent<T: UIView>() -> T? {
        if let superview = superview as? T {
            return superview
        } else {
            if superview != nil {
                return superview?.findParent()
            } else {
                return nil
            }
        }
    }
}

