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
    @State var shouldShowProgressIndicator = true
    
    var body: some View {
        List {
            ForEach(viewModel.charactersList, id: \.self) { character in
                NavigationLink {
                    CharactersDetailsView(viewModel: CharacterDetailsViewModel(character: character))
                } label: {
                    CharactersListCell(character: character)
                }
            }
        }
        .onAppear {
            fetchCharacters()
        }
        .overlay {
            ProgressView()
                .scaleEffect(2, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .hidden(shouldShowProgressIndicator)
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
                shouldShowProgressIndicator = false
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

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self
        case false: self.hidden()
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager()))
    }
}
