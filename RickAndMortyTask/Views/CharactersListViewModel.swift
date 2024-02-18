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
    
    private var nextPageUrlString: String?
    private var firstPageFetched = false
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
        
    func fetchNextPageCharacters() async throws {
        guard let nextPage = nextPageUrlString else {
            return
        }
        guard let downloadedCharacters: APIModel = try await apiManager.fetchData(url: nextPage) else {
            return
        }
        nextPageUrlString = downloadedCharacters.info.next
        charactersList.append(contentsOf: downloadedCharacters.results)
    }
    
    func fetchFirstPageIfNeeded() async throws {
        guard firstPageFetched == false else {
            return
        }
        guard let downloadedCharacters: APIModel = try await apiManager.fetchData(endpoint: .character, id: nil) else {
            return
        }
        firstPageFetched = true
        nextPageUrlString = downloadedCharacters.info.next
        charactersList = downloadedCharacters.results
    }
    
    func isCharacterLastInAlreadyFetched(character: Character) -> Bool {
        character == charactersList.last
    }
}
