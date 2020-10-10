//
//  HomeController.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let reuseIdentifier = "NewsCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var articles =  [Article](){
        didSet{
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Helpers
    
    func configureView(){
        tableView.register(NewsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Type in the category you wish to search"
        searchController.becomeFirstResponder()
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = NewsDetailController()
        controller.article = articles[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        cell.article = articles[indexPath.row]
        return cell
    }
}

// MARK: - SearchDelegate

extension SearchViewController: UISearchResultsUpdating{

func updateSearchResults(for searchController: UISearchController) {
    
    let searchText = searchController.searchBar.text!.replacingOccurrences(of: " ", with: "%2")
    
    NetworkLayer.shared.fetchNews(category: searchText, completion: { result in
        self.articles = result.articles.filter {
            $0.author != nil
        }
        
        self.articles.forEach { $0.date
            = Helpers.shared.dateConverter($0.date)
        }
        print("count: \(self.articles.count)")
    }) { error in
        print(error.localizedDescription)
    }
}
}
