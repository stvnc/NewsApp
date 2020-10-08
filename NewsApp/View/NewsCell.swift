//
//  NewsCell.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    
    var article: Article?{
        didSet{
            configureData()
        }
    }
    
    let newsThumbnail: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.setDimensions(height: 70, width: 70)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 70/4
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let authorLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.setWidth(width: 200)
        label.text = "Author"
        return label
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.text = "Title"
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Date"
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureData(){
        newsThumbnail.sd_setImage(with: URL(string: article?.image ?? ""), completed: nil)
        authorLabel.text = article?.author
        dateLabel.text = article?.date
        titleLabel.text = article?.title
    }
    
    func configureCell(){
        
        addSubview(newsThumbnail)
        newsThumbnail.centerY(inView: self)
        newsThumbnail.anchor(left: leftAnchor, paddingLeft: 16)
        
        addSubview(authorLabel)
        authorLabel.anchor(top: topAnchor, left: newsThumbnail.rightAnchor, paddingTop: 5, paddingLeft: 5)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: authorLabel.topAnchor, bottom: authorLabel.bottomAnchor, right: rightAnchor, paddingRight: 16)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: authorLabel.bottomAnchor, left: authorLabel.leftAnchor, right: dateLabel.rightAnchor, paddingTop: 5)
        
    }
    
}
