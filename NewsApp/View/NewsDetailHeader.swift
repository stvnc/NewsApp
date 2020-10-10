//
//  NewsDetailHeader.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit

class NewsDetailHeader: UIView {
    
    // MARK: - Properties
    
    var article: Article?{
        didSet{
            configureView()
        }
    }
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = article?.title
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = article?.author
        return label
    }()
    
    lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = article?.date
        return label
    }()
    
    // MARK: - Initialization
//
//    init(article: Article){
//        super.init(frame: .zero)
//        self.article = article
//        configureView()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureView(){
        
        backgroundColor = .black
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, right:rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10)
        
        
        let stack = UIStackView(arrangedSubviews: [authorLabel, dateLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        
        addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 24)
        
    }
}
