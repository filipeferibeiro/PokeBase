//
//  NetworkManager.swift
//  PokeBase
//
//  Created by Filipe Fernandes on 12/05/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class NetworkManager {
    static let shared = NetworkManager()
    
    // This class is a Singleton
    private init() {}
    
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        // Check if it's a valid URL
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        // Send request to server
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check if it's a web response and if status code is 200
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        // Try to decode the JSON data to generic type
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
