//
//  UIViewControllerExt.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import MBProgressHUD

typealias AlertHandlerClosue = (_ buttonIndex: Int) -> Void

protocol LoadingViewController {
    
    var hub: MBProgressHUD? {get set}
    
    func showAlert(title: String?, message: String, buttonTitles: String..., completeHandler: AlertHandlerClosue?)
}

fileprivate var kHubKey: UInt8 = 0
extension LoadingViewController where Self: UIViewController {
    
    var hub: MBProgressHUD? {
        set {
            objc_setAssociatedObject(self, &kHubKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            let value = objc_getAssociatedObject(self, &kHubKey)
            return value as? MBProgressHUD
        }
    }
    
    mutating func showLoading() {
        self.showLoading(nil)
    }
    
    mutating func showLoading(_ text: String?, mode: MBProgressHUDMode = .indeterminate) {
        
        if hub != nil {
            hub?.hide(animated: false)
            hub = nil
        }
        
        hub = MBProgressHUD.showAdded(to: view, animated: true)
        
        hub?.mode = mode
        hub?.label.text = text
        hub?.show(animated: true)
    }
    
    mutating func showLoading(from view: UIView, mode: MBProgressHUDMode = .indeterminate) {
        if hub == nil {
            hub = MBProgressHUD.showAdded(to: view, animated: true)
        }
        hub?.mode = mode
        hub?.show(animated: true)
    }
    
    func hideLoading() {
        self.hub?.hide(animated: true)
    }
    
    func showAlert(title: String?, message: String, buttonTitles: String..., completeHandler: AlertHandlerClosue?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var alertAction: UIAlertAction
        alertAction = UIAlertAction(title: buttonTitles[0], style: .cancel, handler: { (action) in
            
            if let completeHandler = completeHandler {
                
                completeHandler(0)
                
            }
            
        })
        
        alertController.addAction(alertAction)
        
        if buttonTitles.count > 1 {
            
            for index in 1..<buttonTitles.count {
                
                alertAction = UIAlertAction(title: buttonTitles[index], style: .cancel, handler: { (action) in
                    
                    if let completeHandler = completeHandler {
                        
                        completeHandler(index)
                        
                    }
                    
                })
                
                alertController.addAction(alertAction)
                
            }
            
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}

extension UIViewController: LoadingViewController {
    
}

extension UIView {
    func hideProgressHUD() {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: self, animated: true)
        })
    }
    
    func showProgressHUD() {
        if MBProgressHUD(for: self) != nil {
            // There is the hud are showing there
            return
        }
        MBProgressHUD.showAdded(to: self, animated: true)
    }
}

