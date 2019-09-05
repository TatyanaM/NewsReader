//
//  ArticlesLoader.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 04/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit
import Alamofire

public typealias FetchArticlesCompletionType = ([Article]?, Error?) -> Void

/// Class for nerwork request. Download list of articles with specific url
/// Uses Alamofire for network requests.
public class ArticlesLoader {

    private let dataSourceURL = URL(string: "https://www.reddit.com/r/swift/.json")!

    public func fetchArticles(completionHandler: @escaping FetchArticlesCompletionType) {

        request(dataSourceURL).response { response in
            guard let data = response.data else {
                completionHandler(nil, response.error)
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(FetchArticleResponse.self, from: data)
                let articles = decodedResponse.result
                completionHandler(articles, nil)
            }
            catch let error {
                completionHandler(nil, error)
            }

        }

    }
}
