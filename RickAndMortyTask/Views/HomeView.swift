//
//  HomeView.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Text("Press button to load characters list")
            NavigationLink {
                CharactersListView(viewModel: CharactersListViewModel(apiManager: APIManager()))
            } label: {
                Text("Press here")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
