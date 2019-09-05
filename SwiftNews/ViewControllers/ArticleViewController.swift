//
//  ArticleViewController.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit
import AlamofireImage

/// View controller for displaying a content of an article
class ArticleViewController: UIViewController {

    public var article: Article?
    
    @IBOutlet private(set) weak var articleImageView: UIImageView!
    @IBOutlet private(set) weak var articleTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = article?.title
        setupView()
    }

    private func setupView() {
        guard let article = article else {
            return
        }

        if let url = article.thumbnailURL, url.isValidURL {
            articleImageView.isHidden = false
            articleImageView.af_setImage(withURL: url)
        }
        else {
            articleImageView.isHidden = true
        }

        articleTextView.text = article.text
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        articleImageView.af_cancelImageRequest()
    }
}
