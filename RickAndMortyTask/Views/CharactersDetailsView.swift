//
//  CharactersDetailsView.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

struct CharactersDetailsView: View {
    @ObservedObject var viewModel: CharacterDetailsViewModel
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: character.image)) { image in
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
                        Text(character.name)
                        Divider()
                        Text(character.status)
                        Divider()
                        Text(character.gender)
                        Divider()
                        Text(character.origin.name)
                        Divider()
                        Text(character.location.name)
                        Divider()
                    } //vstack
                    .font(Font.headline.weight(.light))
                    .padding()
                } //hstack
            } //vstack
            Text("Seen in episodes:")
            ForEach(character.episode, id: \.self) { urlString in
                
                NavigationLink {
                    
                } label: {
                    
                }

                
                
//                NavigationLink(value: item) {
//                    Button {
//                        let episodeId = String(item.components(separatedBy: "/").last ?? "")
//                        Task {
//                            do {
//                                viewModel.fetchEpisodeInfo(id: episodeId)
//                            } catch {
//                                print(error.localizedDescription)
//                            }
//                    } label: {
//                        Text(item.components(separatedBy: "/").last ?? "")
//                    }
//                }
//                .navigationDestination(isPresented: <#T##SwiftUI.Binding<Bool>#>) {
//                    EpisodeDetailsView(episode: <#T##EpisodeModel#>)
//                }
            }
        } //scrollview
    }
}

struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailsView(viewModel: CharacterDetailsViewModel(), character: Character(id: 1, name: "", status: "", gender: "", origin: OriginModel(name: "", url: ""), location: LocationModel(name: "", url: ""), image: "", episode: [""]))
    }
}
