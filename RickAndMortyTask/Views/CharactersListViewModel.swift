//
//  CharactersListViewModel.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import Foundation
import SwiftUI

// TODO move mainactor to view
@MainActor class CharactersListViewModel: ObservableObject {
    private let apiManager: APIManagerProtocol
    @Published var charactersList = [Character]()
    @Published var episodesList = [String]()
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchCharacters() async throws {
        guard let downloadedCharacters: APIModel = try await apiManager.fetchData(endpoint: .character, id: nil) else {
            return
        }
        charactersList = downloadedCharacters.results
    }
}
