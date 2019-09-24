//
//  NewsCellModel.swift
//  NewsapiImplement
//
//  Created by Hung Nguyen Thanh on 9/24/19.
//  Copyright © 2019 Hung Nguyen Thanh. All rights reserved.
//

import UIKit
import BonMot

class NewsCellModel: NSObject {
    let title: NSAttributedString
    let author: NSAttributedString
    let source: NSAttributedString
    let publishedAt: NSAttributedString?
    let descriptionAS: NSAttributedString
    let imageUrl: URL?
    let newsModel: NewsModel
    
    init(_ model: NewsModel) {
        newsModel = model
        title = model.title!.styled(with: StringStyle(
            .font(UIFont.systemFont(ofSize: 17)),
            .color(.black)
        ))
        
        let style = StringStyle(
            .font(UIFont.systemFont(ofSize: 12)),
            .color(.gray)
        )
        
        let prefixStyle = StringStyle(
            .font(UIFont.systemFont(ofSize: 12)),
            .color(.systemTeal)
        )
        let prefix = "<title>%@: </title>"
        
        let authorTitle = String(format: prefix, "author")
        author = (authorTitle + (model.author ?? "N/A")).styled(with: style.byAdding(.xmlRules([
            .style("title", prefixStyle)
        ])))
        
        let sourceTitle = String(format: prefix, "source")
        source = (sourceTitle + model.source!.name!).styled(with: style, .xmlRules([
            .style("title", prefixStyle)
        ]))
        
        if let dateStr = model.publishedAt, let createDate = Date(httpDateString: dateStr) {
            let publishedAtTitle = String(format: prefix, "published at")
            publishedAt = (publishedAtTitle + createDate.toString(dateStyle: .full, timeStyle: .medium)).styled(with: style, .xmlRules([
                .style("title", prefixStyle)
            ]))
        } else {
            publishedAt = nil
        }
        
        descriptionAS = (model.descriptionField ?? "").styled(with: style)
        
        if let urlStr = model.urlToImage, let url = URL(string: urlStr) {
            imageUrl = url
        } else {
            imageUrl = nil
        }
        
        super.init()
    }
}
