//
//  Article.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit

/// Struct for parsing network response
struct FetchArticleResponse: Decodable {
    let result: [Article]

    enum RootCodingKeys: String, CodingKey {
        case data
    }

    enum DataCodingKeys: String, CodingKey {
        case children
    }

    enum ChildrenCodingKeys: String, CodingKey {
        case data
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let dataContainer = try rootContainer.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        result = try dataContainer.decode([Article].self, forKey: .children)
    }
}

/// Object of Article
public class Article: Codable {
    public var title: String?
    public var text: String?
    public var thumbnailURL: URL?

    private enum ContainerCodingKeys: String, CodingKey {
        case data
    }

    private enum CodingKeys: String, CodingKey {
        case title, thumbnailURL = "thumbnail", text = "selftext"
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerCodingKeys.self)
        let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        if let title = try nested.decodeIfPresent(String.self, forKey: .title) {
            self.title = title
        }
        if let url = try nested.decodeIfPresent(String.self, forKey: .thumbnailURL) {
            self.thumbnailURL = URL(string: url)
        }
        if let text = try nested.decodeIfPresent(String.self, forKey: .text) {
            self.text = text
        }
    }
}
