//
//  ArticleCell.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit
import AlamofireImage

/// Custom table view cell for displaying an article data
/// Uses Alamofire for downloading an image data
class ArticleCell: UITableViewCell {
    
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var thumbnailImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.af_cancelImageRequest()
        thumbnailImageView.image = nil
    }
}
