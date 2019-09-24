//
//  UITableViewExt.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellReuseable: ReuseableCell.Type) {
        self.register(cellReuseable.nib, forCellReuseIdentifier: cellReuseable.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}
