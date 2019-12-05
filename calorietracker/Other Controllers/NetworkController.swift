//
//  NetworkController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 01/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation

class NetworkController {
    static let instance: NetworkController = NetworkController()
    
    let baseUrl: URL = URL(string: "https://trackapi.nutritionix.com/v2/")!
    
    func fetchSearchResults(with query: String, completion: @escaping (_ foodEntries: [FoodEntry]?) -> Void) {
        let query: [String: String] = [
            "query": query,
            "common": "false",
            "self": "false",
            "detailed": "true"
        ]
        
        
        
        let url = baseUrl.appendingPathComponent("search/instant").withQueries(query)!
        print(url.absoluteString)
        
        let request = url.addHeaders(for: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let apiWrapper = try? jsonDecoder.decode(ApiWrapper.self, from: data) {
                completion(apiWrapper.branded)
            } else {
                print("a network error had occurred")
                completion(nil)
            }
        }
        task.resume()
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        
        return components?.url
    }
    
    func addHeaders(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.setValue("21736d33", forHTTPHeaderField: "x-app-id")
        request.setValue("ce506e9d766093972fabad5fcf92237a", forHTTPHeaderField: "x-app-key")
        
        return request
    }
}
