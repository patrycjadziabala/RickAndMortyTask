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
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchNextPageCharacters() async throws {
        if let nextPage = nextPageUrlString {
            guard let downloadedCharacters: APIModel = try await apiManager.fetchData(url: nextPage) else {
                return
            }
            nextPageUrlString = downloadedCharacters.info.next
            charactersList.append(contentsOf: downloadedCharacters.results)
        } else {
            guard let downloadedCharacters: APIModel = try await apiManager.fetchData(endpoint: .character, id: nil) else {
                return
            }
            nextPageUrlString = downloadedCharacters.info.next
            charactersList = downloadedCharacters.results
        }
    }
}
