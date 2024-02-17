//
//  CharactersListView.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

struct CharactersListView: View {
    @StateObject var viewModel: CharactersListViewModel = CharactersListViewModel(apiManager: APIManager())
    @State var shouldShowAlert = false
    
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
        .alert(isPresented: $shouldShowAlert) {
           showAlert()
        }
    }
    
    func fetchCharacters() {
        Task {
            do {
                try await viewModel.fetchNextPageCharacters()
            } catch {
                shouldShowAlert = true
            }
        }
        
    }
    
    func showAlert() -> Alert {
        Alert(title: Text("Something went wrong..."),
              primaryButton: .default(Text("Retry"), action: {
            fetchCharacters()
        }),
              secondaryButton: .cancel(Text("Cancel"), action: {
            shouldShowAlert = false
        }))
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager()))
    }
}
