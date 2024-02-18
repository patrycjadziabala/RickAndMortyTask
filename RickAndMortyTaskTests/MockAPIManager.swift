//
//  MockAPIManager.swift
//  RickAndMortyTaskTests
//
//  Created by Patka on 18/02/2024.
//

import Foundation
@testable import RickAndMortyTask

enum MockApiManagerError: Error {
    case genericError
}

class MockApiManager: APIManagerProtocol {
    
    var expectedApiModelFromEndpoint: APIModel?
    var apiModelError: Error?
    var lastEndpointCalled: Endpoint?
    func fetchData<T>(endpoint: RickAndMortyTask.Endpoint, id: String?) async throws -> T? where T : Decodable, T : Encodable {
        if let apiModel = expectedApiModelFromEndpoint {
            return apiModel as? T
        } else if let error = apiModelError {
            throw error
        }
        return nil
    }
    
    var expectedApiModelFromUrl: APIModel?
    var apiModelErrorFromUrl: Error?
    var urlsCalled: [String] = []
    func fetchData<T>(url: String) async throws -> T? where T : Decodable, T : Encodable {
        urlsCalled.append(url)
        if let apiModelFromUrl = expectedApiModelFromUrl {
            return apiModelFromUrl as? T
        } else if let errorFromUrl = apiModelErrorFromUrl {
            throw errorFromUrl
        }
        return nil
    }
}
