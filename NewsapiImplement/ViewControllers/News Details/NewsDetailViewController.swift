//
//  NewsDetailViewController.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/23/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SafariServices

class NewsDetailViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var continueReadingButton: UIButton!
    
    var model: NewsCellModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        continueReadingButton.setTitle("Original news", for: .normal)
        self.bindUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func bindUI() {
        title = model.newsModel.source?.name
        titleLabel.attributedText = model.title
        if let url = model.imageUrl {
            imageView.af_setImage(withURL: url)
        } else {
            imageView.isHidden = true
        }
        
        if model.newsModel.author == nil {
            authorLabel.isHidden = true
        } else {
            authorLabel.attributedText = model.author
        }
        
        sourceLabel.attributedText = model.source
        
        if let publishedAt = model.publishedAt {
            dateLabel.attributedText = publishedAt
        } else {
            dateLabel.isHidden = true
        }
    }

    @IBAction func continueAction(_ sender: AnyObject) {
        if let urlStr = model.newsModel.url, let url = URL(string: urlStr) {
            let safariViewController = SFSafariViewController(url: url)
            self.navigationController?.present(safariViewController, animated: true, completion: nil)
        }
    }
}
