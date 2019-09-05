//
//  ViewController.swift
//  SwiftNews
//
//  Created by Tatiana Mudryak on 03/09/2019.
//  Copyright © 2019 Tatiana Mudryak. All rights reserved.
//

import UIKit
import AlamofireImage

/// View controller for displaying a list of articles
class ArticlesListViewController: UIViewController {

    private let atricleLoader = ArticlesLoader()

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    private(set) var articles = [Article]() {
        didSet {
            tableView.reloadData()
        }
    }

    let articleCellReuseIdentifier = "ArticleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "ArticleCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: articleCellReuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchAtricles), for: .valueChanged)
        tableView.refreshControl = refreshControl

        fetchAtricles()
    }

    @objc func fetchAtricles() {
        spinner.startAnimating()
        
        atricleLoader.fetchArticles { [weak self] (articles, error) in
            DispatchQueue.main.async {
                guard let result = articles else {
                    self?.showErrorMessage(error?.localizedDescription)
                    return
                }

                self?.spinner.stopAnimating()
                self?.tableView.refreshControl?.endRefreshing()
                self?.articles = result
            }
        }
    }
    

    //MARK: Navigation
    func show(article: Article) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        let articleViewController = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        articleViewController.article = article
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    

    //MARL: Helpers
    func showErrorMessage(_ error: String?) {
        let alertController = UIAlertController(title: "Oops.. There was an error fetching articles.", message: error, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: articleCellReuseIdentifier, for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        
        if let url = article.thumbnailURL, url.isValidURL {
            cell.thumbnailImageView.af_setImage(withURL: url) { [weak self] (response) in
                if response.response != nil {
                    DispatchQueue.main.async {
                        self?.tableView.beginUpdates()
                        self?.tableView.endUpdates()
                    }
                }
            }
        }
        return cell
    }

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !articles.isEmpty else {
            return
        }
        let article = articles[indexPath.row]
        show(article: article)
    }
}
