//
//  NewsDetailController.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class NewsDetailController: UIViewController {
    
    // MARK: - Properties
    
    var article: Article?
    
    lazy var header = NewsDetailHeader(article: article!)
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = article?.description
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Helpers
    
    func configureHeight(){
        let numberOfLines = descriptionLabel.maxNumberOfLines + 1
        descriptionLabel.setHeight(height: CGFloat(numberOfLines * 30))
        print(numberOfLines)
    }
    
    func configureView(){
        
        view.backgroundColor = .white
        header.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.addSubview(header)
        header.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5)
        
        configureHeight()
        
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: header.bottomAnchor, left: header.leftAnchor, right: header.rightAnchor, paddingTop: 15, paddingLeft: 16, paddingRight: 16)
        
    }
}
