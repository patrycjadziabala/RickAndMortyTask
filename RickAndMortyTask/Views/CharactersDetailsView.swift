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
                LazyVGrid(columns: [GridItem( .fixed(100), alignment: .topLeading), GridItem(alignment: .topLeading)], spacing: 20) {
                    Text("Name:")
                        .padding(.leading, 20)
                        .font(Font.headline.weight(.bold))
                    Text(viewModel.character.name)
                        .font(Font.headline.weight(.light))
                    Text("Status:")
                        .padding(.leading, 20)
                        .font(Font.headline.weight(.bold))
                    Text(viewModel.character.status)
                        .font(Font.headline.weight(.light))
                    Text("Gender:")
                        .padding(.leading, 20)
                        .font(Font.headline.weight(.bold))
                    Text(viewModel.character.gender)
                        .font(Font.headline.weight(.light))
                    Text("Origin:")
                        .font(Font.headline.weight(.bold))
                        .padding(.leading, 20)
                    Text(viewModel.character.origin.name)
                        .font(Font.headline.weight(.light))
                    Text("Location:")
                        .padding(.leading)
                        .font(Font.headline.weight(.bold))
                    Text(viewModel.character.location.name)
                        .font(Font.headline.weight(.light))
                }
                .padding()
                Text("Seen in episodes:")
                    .font(Font.headline.weight(.bold))
                    .padding()
//                List {
//                    ForEach(viewModel.character.episode, id: \.self) {
//                        NavigationLink {
//                            EpisodeDetailsView(id: viewModel.getEpisodeNumberString(url: urlString) ?? ""))
//                        } label: {
//                            Text("Episode \(viewModel.getEpisodeNumberString(url: urlString) ?? "")")
//                        }
//                    }
//                }
//                List(viewModel.character.episode, id: \.self) { urlString in
//                    NavigationLink(destination: EpisodeDetailsView(id: viewModel.getEpisodeNumberString(url: urlString) ?? "")) {
//                        Text("Episode \(viewModel.getEpisodeNumberString(url: urlString) ?? "")")
//                    }
//                }
                
                ForEach(viewModel.character.episode, id: \.self) { urlString in
                    NavigationLink(destination: EpisodeDetailsView(id: viewModel.getEpisodeNumberString(url: urlString) ?? "")) {
                        Text("Episode \(viewModel.getEpisodeNumberString(url: urlString) ?? "")")
                    }
                }
            }
        }
        .background(Image("galaxy-background")
            .resizable()
            .scaledToFill()
            .opacity(0.8))
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
