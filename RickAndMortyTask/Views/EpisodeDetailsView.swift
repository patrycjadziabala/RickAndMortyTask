//
//  EpisodeDetailsView.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import SwiftUI

struct EpisodeDetailsView: View {
    @StateObject var viewModel: EpisodeDetailsViewModel = EpisodeDetailsViewModel(apiManager: APIManager())
    @State var id: String
    @State var shouldShowAlert = false
    
    init(id: String) {
        self.id = id
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem( .fixed(100), alignment: .trailing), GridItem(alignment: .leading)], spacing: 20) {
                if let episode = viewModel.episode {
                    Text("Name:")
                    Text(episode.name)
                        .padding(.leading)
                    Text("Air date:")
                    Text(episode.air_date)
                        .padding(.leading)
                    Text("Episode:")
                    Text(episode.episode)
                        .padding(.leading)
                }
            }
            Text("Number of characters in episode: \(viewModel.getNumberOfCharactersInEpisode())")
        }.onAppear {
            fetchEpisodeInfo()
        }
        .padding()
        .alert(isPresented: $shouldShowAlert, content: {
            showAlert()
        })
        .navigationTitle("Episode Details")
    }
    
    func fetchEpisodeInfo() {
        Task {
            do {
                try await viewModel.fetchEpisodeInfo(episodeId: id)
            } catch {
                shouldShowAlert = true
            }
        }
    }
    
    func showAlert() -> Alert {
        Alert(title: Text("Something went wrong..."),
              primaryButton: .default(Text("Retry"), action: {
            fetchEpisodeInfo()
        }),
              secondaryButton: .cancel(Text("Cancel"), action: {
            shouldShowAlert = false
        }))
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(id: "")
    }
}
