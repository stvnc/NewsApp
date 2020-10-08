//
//  Article.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

class Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    var date: String
    let image: String?
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case description = "description"
        case date = "publishedAt"
        case image = "urlToImage"
        case content = "content"
    }
}
