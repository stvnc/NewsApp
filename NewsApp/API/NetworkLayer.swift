//
//  NetworkLayer.swift
//  NewsApp
//
//  Created by Vincent Angelo on 06/10/20.
//  Copyright © 2020 Vincent Angelo. All rights reserved.
//

import Foundation

struct NetworkLayer {
    
    static var shared = NetworkLayer()
    
    private init(){}
    
    let session = URLSession.shared
    
    func fetchNews(category: String, completion: @escaping(Result) -> Void, errorHandler: @escaping(Error) -> Void) {
        
        let currentDate = Helpers.shared.getCurrentDate()
        
        guard let url = URL(string: "http://newsapi.org/v2/everything?q=\(category)&from=\(currentDate)&sortBy=publishedAt&apiKey=\(apiKey)") else { return }
        
        print("URL: \(url)")
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("Error in news: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else { return }
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }
            
            do {
                let newsData = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    completion(newsData)
                }
            }catch {
                print("Error in fetching news: \(error.localizedDescription)")
                return
            }
        }.resume()
    }
    
}
