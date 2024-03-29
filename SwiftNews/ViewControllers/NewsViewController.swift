//
//  NewsViewController.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit
import SDWebImage

/// View controller for displaying a content of an article
class NewsViewController: UIViewController {

    public var newsItem: NewsItem?
    
    @IBOutlet private(set) weak var articleImageView: UIImageView!
    @IBOutlet private(set) weak var articleTextView: UITextView!
    @IBOutlet weak var arcticleTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = newsItem?.title
        setupView()
    }

    private func setupView() {
        guard let newsItem = newsItem else {
            return
        }

        if let url = newsItem.urlToImage, url.isValidURL {
            articleImageView.isHidden = false
            articleImageView.sd_setImage(with: url)
        }
        else {
            articleImageView.isHidden = true
        }

        arcticleTitleLabel.text = newsItem.title
        articleTextView.text = newsItem.content
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    //    articleImageView.af_cancelImageRequest()
    }
}
