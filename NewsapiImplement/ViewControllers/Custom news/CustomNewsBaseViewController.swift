//
//  CustomNewsBaseViewController.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit

class CustomNewsBaseViewController: NewsBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func configRequest() {
        let country = ConfigService.shared.stored(for: .country) ?? "us"
        request = NewsService.NewsRequest(query: country, pageSize: 20, totalNews: 0, currentPage: 0)
    }

}
