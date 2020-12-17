//
//  Fetch.swift
//  crelo
//
//  Created by michelle gleed on 5/12/20.
//  Copyright © 2020 michelle gleed. All rights reserved.
//

import Foundation

func fetch<T: Codable> (type: T.Type, url: String, method: String, token: String?, body: Data?, completion: @escaping (T?, String?) -> Void) {

    guard let url = URL(string: url) else {
        completion(nil, "Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = method
    
    if let token = token {
        request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    if let body = body {
    request.httpBody = body
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            print("got some data. size is ", data)
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    /// update the UI
                    let responseObject = decodedResponse
                    completion(responseObject, nil)
                }
            }
            else {
               completion(nil, "couldn't decode the data")
           }
            
///     For Debugging Issues w my Codable Models
//            let decodedResponse = try! JSONDecoder().decode(T.self, from: data)
//                DispatchQueue.main.async {
//                    /// update the UI
//                    let responseObject = decodedResponse
//                    completion(responseObject, nil)
//                    print(decodedResponse)
//            }
        }
    }.resume()
}
