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
    let cellDatas = BehaviorRelay<[NewsCellModel]>(value: [])
    var request: NewsService.NewsRequest!
    let newsService = NewsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        configRequest()
        refershData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configRequest() {
        
    }
    
    func configTableView() {
        tableView.pullToRefresh.pullToRefreshLoadMoreDelegate = self
        tableView.pullToRefresh.indicatorTintColor = UIColor.gray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellReuseable: NewsTableViewCell.self)
        
        cellDatas.bind(to: tableView.rx.items(cellIdentifier: NewsTableViewCell.identifier,
                                              cellType: NewsTableViewCell.self))
        { tv, model, cell in
            cell.model = model
        }.disposed(by: disposeBag)
    }

    func endLoad() {
        tableView.pullToRefresh.setPullState(state: MRPullToRefreshLoadMore.ViewState.Normal)
        tableView.pullToRefresh.setLoadMoreState(state: MRPullToRefreshLoadMore.ViewState.Normal)
    }
    
    func refershData() {
        request?.calculatorForReload()
        self.showOrHideLoading(isShow: true)
        newsService.topHeadline(request) {[weak self] newsModels, status, code, message in
            self?.showOrHideLoading(isShow: false)
            self?.cellDatas.accept([])
            if let message = message {
                self?.showLoadDataError(message: message)
            } else {
                self?.appendData(newsModels ?? [])
            }
            
            self?.endLoad()
        }
    }
    
    func loadMoreData() {
        if request.canLoadMore() {
            request.calculatorForLoadMore()
            newsService.customSearch(request) {[weak self] newsModels, status, code, message in
                self?.showOrHideLoading(isShow: false)
                if let message = message {
                    self?.showLoadDataError(message: message)
                } else {
                    self?.appendData(newsModels ?? [])
                }
                
                self?.endLoad()
            }
        } else {
            self.endLoad()
        }
    }
    
    func showLoadDataError(message: String) {
        self.showAlert(title: "Error", message: message, buttonTitles: "Ok", completeHandler: nil)
    }
    
    func appendData(_ newsModels: [NewsModel]) {
        let datas: [NewsCellModel] = newsModels.map({
            NewsCellModel($0)
        })
        
        var cells = cellDatas.value
        cells.append(contentsOf: datas)
        cellDatas.accept(cells)
    }
}

extension NewsBaseViewController: MRPullToRefreshLoadMoreDelegate {
    func viewShouldRefresh(scrollView: UIScrollView) {
        refershData()
    }
    
    func viewShouldLoadMore(scrollView: UIScrollView) {
        loadMoreData()
    }
}
