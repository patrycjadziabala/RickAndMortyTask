//
//  CharactersListView.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var viewModel: CharactersListViewModel = CharactersListViewModel(apiManager: APIManager())
    
    var body: some View {
        List {
            ForEach(viewModel.charactersList, id: \.id) { character in
                NavigationLink {
                    CharactersDetailsView(viewModel: CharacterDetailsViewModel(character: character))
                } label: {
                    CharactersListCell(character: character)
                }
            }
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .onAppear {
                    fetchCharacters()
                }
        }
        .navigationTitle("Characters List")
    }
    
    func fetchCharacters() {
        Task {
            do {
                try await viewModel.fetchNextPageCharacters()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager()))
    }
}
