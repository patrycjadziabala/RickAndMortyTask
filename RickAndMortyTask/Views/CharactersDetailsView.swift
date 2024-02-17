//
//  CharactersDetailsView.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

struct CharactersDetailsView: View {
    @ObservedObject var viewModel: CharacterDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: viewModel.character.image)) { image in
                    image.resizable()
                        .clipShape(Circle())
                        .frame(width: 360)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                Spacer()
                HStack {
                    VStack {
                        Text("Name")
                        Divider()
                        Text("Status")
                        Divider()
                        Text("Gender")
                        Divider()
                        Text("Origin")
                        Divider()
                        Text("Location")
                        Divider()
                    } //vstack
                    .font(Font.headline.weight(.bold))
                    .padding()
                    Divider()
                    VStack {
                        Text(viewModel.character.name)
                        Divider()
                        Text(viewModel.character.status)
                        Divider()
                        Text(viewModel.character.gender)
                        Divider()
                        Text(viewModel.character.origin.name)
                        Divider()
                        Text(viewModel.character.location.name)
                        Divider()
                    } //vstack
                    .font(Font.headline.weight(.light))
                    .padding()
                } //hstack
                Text("Seen in episodes:")
                ForEach(viewModel.character.episode, id: \.self) { urlString in
                    NavigationLink(destination: EpisodeDetailsView(viewModel: EpisodeDetailsViewModel(apiManager: APIManager(), episodeId: viewModel.getEpisodeNumberString(url: urlString) ?? ""))) {
                        Text("Episode \(viewModel.getEpisodeNumberString(url: urlString) ?? "")")
                    }
                }
            } //vstack
        }
    } //scrollview
}


struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailsView(viewModel: CharacterDetailsViewModel(character: Character(id: 1, name: "", status: "", gender: "", origin: OriginModel(name: "", url: ""), location: LocationModel(name: "", url: ""), image: "", episode: [""])))
    }
}
