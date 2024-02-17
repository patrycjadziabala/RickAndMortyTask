//
//  HomeView.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Text("Press button to load characters list")
            NavigationLink(destination: CharactersListView()) {
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
