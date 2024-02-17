//
//  CharactersDetailsView.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

struct CharactersDetailsView: View {
    @EnvironmentObject var persistanceManager: PersistenceManager
    @StateObject var viewModel: CharacterDetailsViewModel
    
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
                LazyVGrid(columns: [GridItem( .fixed(100), alignment: .leading), GridItem(alignment: .leading)], spacing: 20) {
                    Text("Name")
                        .padding(.leading)
                        .padding(5)
                    Text(viewModel.character.name)
                    Text("Status")
                        .padding(.leading)
                        .padding(5)
                    Text(viewModel.character.status)
                    Text("Gender")
                        .padding(.leading)
                        .padding(5)
                    Text(viewModel.character.gender)
                    Text("Origin")
                        .padding(.leading)
                        .padding(5)
                    Text(viewModel.character.origin.name)
                    Text("Location")
                        .padding(.leading)
                        .padding(5)
                    Text(viewModel.character.location.name)
                }
//                HStack
                Text("Seen in episodes:")
                ForEach(viewModel.character.episode, id: \.self) { urlString in
                    NavigationLink(destination: EpisodeDetailsView(id: viewModel.getEpisodeNumberString(url: urlString) ?? "")) {
                        Text("Episode \(viewModel.getEpisodeNumberString(url: urlString) ?? "")")
                    }
                }
            }
        }
        .navigationTitle("Character Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    persistanceManager.togglePersisted(model: viewModel.character)
                } label: {
                    Image(systemName: persistanceManager.isPersisted(model: viewModel.character) ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow)
                        .shadow(radius: 1)
                }
            }
        }
    }
}


struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailsView(viewModel: CharacterDetailsViewModel(character: Character(id: 1, name: "", status: "", gender: "", origin: OriginModel(name: "", url: ""), location: LocationModel(name: "", url: ""), image: "", episode: [""])))
    }
}
