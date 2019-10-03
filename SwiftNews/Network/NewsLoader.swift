//
//  ArticlesLoader.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 04/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit

public typealias FetchArticlesCompletionType = ([NewsItem]?, Error?) -> Void

class NewsLoader {

    class func loadNews(completion: @escaping FetchArticlesCompletionType) {
        NetworkRequestService.request(router: NewsRouter.getAllNews) { (result: Result<FetchArticleResponse, Error>) in
            switch result {
            case .success(let responce):
                completion(responce.result, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
