//
//  Helpers.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct Helpers {
    
    static var shared = Helpers()
    
    private init () {}
    
    func dateConverter(_ dateVal:  String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterResult = DateFormatter()
        dateFormatterResult.dateFormat = "MM-dd-yyyy HH:mm"
        
        guard let date = dateFormatterGet.date(from: dateVal) else { return "" }
        
        return dateFormatterResult.string(from: date)
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        return formatter.string(from:now)
    }
}
