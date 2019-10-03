//
//  NewsAPI.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 10/3/19.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import Foundation

private let APIKey = "6557b4c1af914ade855cd216c0220a1f"

enum NewsRouter: Router {
    case getAllNews
    case getSpecificSourceNews

    var scheme: String {
        return "https"
    }

    var host: String {
        return "newsapi.org"
    }

    var path: String {
        switch self {
        case .getAllNews:
            return "/v2/top-headlines"
        default:
            return ""
        }
    }

    var parameters: [URLQueryItem] {
        var items = [URLQueryItem(name: "apiKey", value: APIKey)]

        switch self {
        case .getAllNews:
            items.append(URLQueryItem(name: "country", value: "us"))
            return items
        default:
            return items
        }
    }

    var method: String {
        switch self {
        case .getAllNews, .getSpecificSourceNews:
            return "GET"
        }
    }
}

