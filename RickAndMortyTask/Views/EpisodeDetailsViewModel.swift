//
//  EpisodeDetailsViewModel.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import Foundation

class EpisodeDetailsViewModel: ObservableObject {
    @Published var episode: EpisodeModel?
    let apiManager: APIManagerProtocol
    var episodeId: String
    
    init(apiManager: APIManagerProtocol, episodeId: String) {
        self.apiManager = apiManager
        self.episodeId = episodeId
    }
    
   @MainActor func fetchEpisodeInfo() async throws {
        guard let downloadedEpisode: EpisodeModel = try await apiManager.fetchData(endpoint: .episode, id: episodeId) else {
            return
        }
        episode = downloadedEpisode
    }
    
    func getNumberOfCharactersInEpisode() -> Int {
        episode?.characters.count ?? 0
    }
}
