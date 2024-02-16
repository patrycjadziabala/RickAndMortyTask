//
//  CharactersListView.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersListViewModel
    
    init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        fetchCharacters()
    }
    
    var body: some View {
        ScrollView {
            Text("Characters List")
            ForEach (viewModel.characterList) { character in
                CharactersListCell(character: character)
            }
        }
    }

    
    func fetchCharacters() {
        Task {
            do {
               try await viewModel.fetchCharacters()
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
