//
//  ViewController.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit

/// View controller for displaying a list of news
class NewsListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    private(set) var news = [NewsItem]() {
        didSet {
            tableView.reloadData()
        }
    }

    let newsCellReuseIdentifier = "NewsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "NewsCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: newsCellReuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchAllNews), for: .valueChanged)
        tableView.refreshControl = refreshControl

        fetchAllNews()
    }

    @objc func fetchAllNews() {
        spinner.startAnimating()

        NewsLoader.loadNews { [weak self] (news, error) in
            guard let news = news else {
                self?.showErrorMessage(error?.localizedDescription)
                return
            }
            self?.spinner.stopAnimating()
            self?.tableView.refreshControl?.endRefreshing()
            self?.news = news
        }
    }
    

    //MARK: Navigation
    func show(_ newsItem: NewsItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        newsViewController.newsItem = newsItem
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    

    //MARL: Helpers
    func showErrorMessage(_ error: String?) {
        let alertController = UIAlertController(title: "Oops.. There was an error fetching newss.", message: error, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellReuseIdentifier, for: indexPath) as! NewsCell
        let newsItem = news[indexPath.row]
        cell.sourceNameLabel.text = newsItem.source?.name
        cell.dateLabel.text = newsItem.publishedAt
        cell.titleLabel.text = newsItem.title
        
//        if let url = news.thumbnailURL, url.isValidURL {
//            cell.thumbnailImageView.af_setImage(withURL: url) { [weak self] (response) in
//                if response.response != nil {
//                    DispatchQueue.main.async {
//                        self?.tableView.beginUpdates()
//                        self?.tableView.endUpdates()
//                    }
//                }
//            }
//        }
        return cell
    }

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !news.isEmpty else {
            return
        }
        let newsItem = news[indexPath.row]
        show(newsItem)
    }
}
