//
//  APIManager.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import Foundation

protocol APIManagerProtocol {
    func fetchData<T: Codable>(endpoint: Endpoint, id: String?) async throws -> T?
}

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case badStatus
    case badResponse
    case failedToDecodeResponse
}

enum Endpoint: String {
    case character
    case episode
}

class APIManager: APIManagerProtocol {
    
    private let baseUrlString = "https://rickandmortyapi.com/api/<endpoint>"
    
    private func buildUrlString(for endpoint: Endpoint) -> String? {
        let urlString = baseUrlString.replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return urlString
    }
    
    private func buildUrlString(for endpoint: Endpoint, id: String) -> String? {
        let urlString = baseUrlString.replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .appending(id)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return urlString
    }
    
    func fetchData<T: Codable>(endpoint: Endpoint, id: String?) async throws -> T? {
        let urlString: String
        if let id = id {
            guard let url = buildUrlString(for: endpoint, id: id) else {
                throw NetworkError.invalidURL
            }
            urlString = url
        } else {
            guard let url = buildUrlString(for: endpoint) else {
                throw NetworkError.invalidURL
            }
            urlString = url
        }
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badStatus
        }
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.failedToDecodeResponse
        }
        return decodedResponse
    }
}
