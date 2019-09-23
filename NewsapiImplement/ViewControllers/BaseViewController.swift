//
//  BaseViewController.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @discardableResult
    func showOrHideLoading(isShow: Bool, text: String? = nil, mode: MBProgressHUDMode = .indeterminate) -> MBProgressHUD? {
        
        var `self` = self
        if isShow {
            self.showLoading(text, mode: mode)
        } else {
            self.hideLoading()
        }
        
        return self.hub
    }

}
