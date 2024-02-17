//
//  EpisodeDetailsView.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import SwiftUI

struct EpisodeDetailsView: View {
    @ObservedObject var viewModel: EpisodeDetailsViewModel
    
    init(viewModel: EpisodeDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("Name")
                        Text("Air date")
                        Text("Episode")
                    }
                    Divider()
                        .foregroundColor(.gray)
                    VStack {
                        if let episode = viewModel.episode {
                            Text(episode.name)
                            Text(episode.air_date)
                            Text(episode.episode)
                        }
                    }
                }
                Text("Number of characters in episode: \(viewModel.getNumberOfCharactersInEpisode())")
            }
            
        }.onAppear {
            fetchEpisodeInfo()
        }
    }
    
    func fetchEpisodeInfo() {
        Task {
            do {
                try await viewModel.fetchEpisodeInfo()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(apiManager: APIManager(), episodeId: ""))
    }
}
