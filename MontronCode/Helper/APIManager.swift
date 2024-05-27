//
//  APIManager.swift
//  MontronCode
//
//  Created by Rashika Dube on 27/05/24.
//

import Foundation

// MARK: - Enum

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

// MARK: - Class APIManager

class APIManager {
    
    // MARK: Singleton Instance
    
    static let shared = APIManager()
    private init() {}
    
    // MARK: Public Methods
    
    func fetch<T: Decodable>(petFrom url: URL, completion: @escaping (Result<T, DataError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(DataError.invalidData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(DataError.network(error)))
            }
            
        }.resume()
    }
}
