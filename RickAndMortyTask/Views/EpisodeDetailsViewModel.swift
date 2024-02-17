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
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchEpisodeInfo(id: String) async throws {
        guard let downloadedEpisode: EpisodeModel = try await apiManager.fetchData(endpoint: .episode, id: id) else {
            return
        }
        episode = downloadedEpisode
    }
}
