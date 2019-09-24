//
//  CustomNewsBaseViewController.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit

class CustomNewsBaseViewController: NewsBaseViewController {

    @IBOutlet weak var keywordSegmentedControl: UISegmentedControl!
    
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
        keywordSegmentedControl.removeAllSegments()

        ConfigService.Keyword.array.forEach({
            keywordSegmentedControl.insertSegment(withTitle: $0.rawValue,
                                                  at: keywordSegmentedControl.numberOfSegments,
                                                  animated: false)
        })
        
        var keywordStr = ConfigService.shared.stored(for: .keyword)
        if keywordStr == nil {
            keywordStr = ConfigService.Keyword.bitcoin.rawValue
            ConfigService.shared.store(keywordStr, for: .keyword)
        }
        
        let keyword = ConfigService.Keyword(rawValue: keywordStr!) ?? .bitcoin
        let index = ConfigService.Keyword.array.firstIndex(of: keyword) ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.keywordSegmentedControl.selectedSegmentIndex = index
        }
        
        selectedKeyword(at: index)
    }
    
    override func refershData() {
        request?.calculatorForReload()
        self.showOrHideLoading(isShow: true)
        newsService.customSearch(request) {[weak self] newsModels, status, code, message in
            self?.showOrHideLoading(isShow: false)
            self?.processRefreshData(newsModels, status: status, code: code, message: message)
        }
    }
    
    override func loadMoreData() {
        if request.canLoadMore() {
            request.calculatorForLoadMore()
            newsService.customSearch(request) {[weak self] newsModels, status, code, message in
                self?.showOrHideLoading(isShow: false)
                self?.processLoadMoreData(newsModels, status: status, code: code, message: message)
            }
        } else {
            self.endLoad()
        }
    }

    private func selectedKeyword(at index: Int) {
        let keyword = ConfigService.Keyword.array[index]
        ConfigService.shared.store(keyword.rawValue, for: .keyword)
        request = NewsService.NewsRequest(query: keyword.rawValue, pageSize: 20, totalNews: 0, currentPage: 0)
    }
    
    @IBAction func keywordValueChanged(_ sender: Any) {
        selectedKeyword(at: keywordSegmentedControl.selectedSegmentIndex)
        refershData()
    }
    
}
