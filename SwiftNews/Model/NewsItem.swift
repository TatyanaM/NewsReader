//
//  NewsItem.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit

/// Struct for parsing network response
struct FetchArticleResponse: Codable {
    let result: [NewsItem]

    enum RootCodingKeys: String, CodingKey {
        case status, totalResults, articles
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        result = try rootContainer.decode([NewsItem].self, forKey: .articles)
    }
}

/// News Item object
public class NewsItem: Codable {
    public var name: String?
    public var author: String?
    public var title: String?
    public var content: String?
    public var url: URL?
    public var urlToImage: URL?
    public var publichedAt: String?
}
