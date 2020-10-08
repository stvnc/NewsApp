//
//  Result.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct Result: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}
