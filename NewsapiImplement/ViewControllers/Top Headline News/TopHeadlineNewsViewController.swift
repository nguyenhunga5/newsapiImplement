//
//  TopHeadlineNewsViewController.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit

class TopHeadlineNewsViewController: NewsBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.viewControllers?.forEach({
            let title: String
            let vc = ($0 as! UINavigationController).viewControllers[0]
            if let _ = vc as? TopHeadlineNewsViewController {
                title = "Top Headline News"
            } else if let _ = vc as? CustomNewsBaseViewController {
                title = "Custom News"
            } else {
                title = "Profile"
            }
            
            vc.title = title
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeCountryNotification(_:)),
                                               name: .countryChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .countryChanged, object: nil)
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
        let country = ConfigService.shared.stored(for: .country)
        
        if country == nil {
            ConfigService.shared.changeCountry(from: self)
            return
        }
        
        request = NewsService.NewsRequest(query: country!, pageSize: 20, totalNews: 0, currentPage: 0)
    }
    
    override func refershData() {
        if request == nil {
            return
        }
        request?.calculatorForReload()
        self.showOrHideLoading(isShow: true)
        newsService.topHeadline(request) {[weak self] newsModels, status, code, message in
            self?.showOrHideLoading(isShow: false)
            self?.processRefreshData(newsModels, status: status, code: code, message: message)
        }
    }
    
    override func loadMoreData() {
        if request.canLoadMore() {
            request.calculatorForLoadMore()
            newsService.topHeadline(request) {[weak self] newsModels, status, code, message in
                self?.showOrHideLoading(isShow: false)
                self?.processLoadMoreData(newsModels, status: status, code: code, message: message)
            }
        } else {
            self.endLoad()
        }
    }
    
    @objc func changeCountryNotification(_ notification: Notification) {
        configRequest()
        refershData()
    }
}
