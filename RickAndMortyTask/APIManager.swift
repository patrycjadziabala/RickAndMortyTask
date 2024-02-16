//
//  APIManager.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import Foundation

protocol APIManagerProtocol {
    func fetchCharactersList<T: Codable>() async -> T?
}

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case badStatus
    case badResponse
    case failedToDecodeResponse
}

class APIManager: APIManagerProtocol {
    
    let baseUrlString = "https://rickandmortyapi.com/api/character"
    
    func fetchCharactersList<T: Codable>() async -> T? {
      
        do {
            guard let url = URL(string: baseUrlString) else { throw NetworkError.invalidURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            return decodedResponse
            
        } catch NetworkError.invalidURL {
            print("Invalid URL")
        } catch NetworkError.badResponse {
            print("Bad response")
        } catch NetworkError.badStatus {
            print("Did not get 2xx status cose from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading data")
        }
        return nil
    }
}
