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
    @State var shouldShowProgressIndicator = true
    
    init(id: String) {
        self.id = id
    }
    
    var body: some View {
        ScrollView {
            if let episode = viewModel.episode {
                LazyVGrid(columns: [GridItem(.fixed(100), alignment: .topTrailing), GridItem(alignment: .topLeading)], spacing: 20) {
                    Text("Name:")
                        .font(Font.headline.weight(.bold))
                    Text(episode.name)
                        .padding(.leading)
                        .font(Font.headline.weight(.light))
                    Text("Air date:")
                        .font(Font.headline.weight(.bold))
                    Text(episode.air_date)
                        .font(Font.headline.weight(.light))
                        .padding(.leading)
                    Text("Episode:")
                        .font(Font.headline.weight(.bold))
                    Text(episode.episode)
                        .font(Font.headline.weight(.light))
                        .padding(.leading)
                    Text("Number of characters in episode:")
                        .font(Font.headline.weight(.bold))
                        .multilineTextAlignment(.trailing)
                    Text("\(viewModel.getNumberOfCharactersInEpisode())")
                        .font(Font.headline.weight(.light))
                        .padding(.leading)
                }
                .padding()
            }
        }
        .background(Image("galaxy-background")
            .resizable()
            .scaledToFill()
            .opacity(0.7))
        .overlay {
            ProgressView()
                .scaleEffect(2, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .hidden(shouldShowProgressIndicator)
        }
        .onAppear {
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
                shouldShowProgressIndicator = false
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
