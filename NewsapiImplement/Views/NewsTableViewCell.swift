//
//  NewsTableViewCell.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/24/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: NewsCellModel! {
        didSet {
            configCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell() {
        
        let resizeImageView = {[weak self] (show: Bool) in
            self?.newsImageViewWidthConstraint.constant = show ? 120 : 0
            UIView.animate(withDuration: 0.15) {
                self?.newsImageView.layoutIfNeeded()
            }
        }
        
        if let url = model.imageUrl {
            newsImageView.af_setImage(withURL: url) {[weak self] (response: DataResponse<UIImage>) in
                if let image = response.value {
                    self?.newsImageView.image = image
                    resizeImageView(true)
                } else {
                    self?.newsImageView.image = nil
                    resizeImageView(false)
                }
            }
        } else {
            self.newsImageView.image = nil
            resizeImageView(false)
        }
        
        titleLabel.attributedText = model.title
        authorLabel.attributedText = model.author
        sourceLabel.attributedText = model.source
        descriptionLabel.attributedText = model.descriptionAS
    }
}
