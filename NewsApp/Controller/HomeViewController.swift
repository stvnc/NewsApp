//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Vincent Angelo on 10/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    // MARK: - Properties
    
    private let reuseIdentifier = "NewsCell"
    
    let tableView = UITableView()
    
    var headerArticle: Article? {
        didSet{
//            newsHeader.article = headerArticle
        }
    }
    
    var articles =  [Article]() {
        didSet{
            tableView.reloadData()
        }
    }
    
//    lazy var newsHeader = NewsDetailHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNews()
        
        configureView()
        
        configureTableView()
    }
    
    // MARK: - Helpers
    
    func configureView(){
        view.backgroundColor = .white
        
        self.title = appTitle
        
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchTapped))
//        view.addSubview(newsHeader)
//        newsHeader.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right:view.rightAnchor, paddingBottom: 20)
//        tableView.anchor(top: newsHeader.bottomAnchor, left: newsHeader.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: newsHeader.rightAnchor, paddingTop: 20, paddingBottom: 5)
        
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func fetchNews(){
        NetworkLayer.shared.fetchNews(category: "Election", completion: { result in
            self.headerArticle = result.articles.first
        }) { error in
            print("Error while fetching header article with error : \(error.localizedDescription)")
        }

        NetworkLayer.shared.fetchNews(category: "Indonesia", completion: { result in
            self.articles = result.articles
            
            self.articles.forEach { $0.date
                = Helpers.shared.dateConverter($0.date)
            }
        }) { error in
            print("Error while fetching articles with error: \(error.localizedDescription)")
        }
        
    }
    
    @objc func handleSearchTapped(){
        let controller = SearchViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "News of the day"
    }
}
