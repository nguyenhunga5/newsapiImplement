//
//  Logger.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/24/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import SwiftyBeaver
let log = SwiftyBeaver.self

func configLog(configs: [BaseDestination]) {
    configs.forEach({
        log.addDestination($0)
    })
}
