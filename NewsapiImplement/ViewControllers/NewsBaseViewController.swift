//
//  NewsBaseViewController.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MRPullToRefreshLoadMore

class NewsBaseViewController: BaseViewController {

    @IBOutlet weak var tableView: MRTableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configTableView() {
        tableView.pullToRefresh.pullToRefreshLoadMoreDelegate = self
        tableView.pullToRefresh.indicatorTintColor = UIColor.gray
        tableView.rowHeight = UITableView.automaticDimension
    }

    
    func refershData() {
        tableView.pullToRefresh.setPullState(state: MRPullToRefreshLoadMore.ViewState.Normal)
    }
    
    func loadMoreData() {
        tableView.pullToRefresh.setLoadMoreState(state: MRPullToRefreshLoadMore.ViewState.Normal)
    }
}

extension NewsBaseViewController: MRPullToRefreshLoadMoreDelegate {
    func viewShouldRefresh(scrollView: UIScrollView) {
    
    }
    
    func viewShouldLoadMore(scrollView: UIScrollView) {
        
    }
    
    
}
