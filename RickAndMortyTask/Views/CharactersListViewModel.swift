//
//  CharactersListViewModel.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import Foundation

@MainActor class CharactersListViewModel: ObservableObject {
    private let apiManager: APIManagerProtocol
    @Published var characterList = [Character]()
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchCharacters() async throws {
        guard let downloadedCharacters: APIModel = await apiManager.fetchCharactersList() else {
            return
        }
        characterList = downloadedCharacters.results
    }
}
