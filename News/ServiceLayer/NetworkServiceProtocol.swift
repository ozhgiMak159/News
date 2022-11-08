//
//  NetworkServiceProtocol.swift
//  News
//
//  Created by Maksim  on 28.10.2022.
//
 import Foundation

protocol NetworkServiceProtocol {
    func getComments(completion: @escaping(Result<News?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getComments(completion: @escaping (Result<News?, Error>) -> Void) {
        let urlString = "https://inshorts.deta.dev/news?category=business"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data!)
                completion(.success(news))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
}
