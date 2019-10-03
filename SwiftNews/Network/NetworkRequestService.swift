//
//  NewsLoadingService.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 10/3/19.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import Foundation

protocol Router {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: String { get }
    var parameters: [URLQueryItem] { get }
}


class NetworkRequestService {

    class func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.path = router.path
        components.host = router.host
        components.queryItems = router.parameters

        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = router.method

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, responce, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard responce != nil, let data = data else {
                return
            }

            let responceObject = try! JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(responceObject))
            }

        }
        dataTask.resume()
    }
}
