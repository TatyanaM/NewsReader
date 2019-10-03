//
//  NewsCell.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit

/// Custom table view cell for displaying an article data
class NewsCell: UITableViewCell {
    
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var thumbnailImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
       // thumbnailImageView.af_cancelImageRequest()
        thumbnailImageView.image = nil
    }
}
