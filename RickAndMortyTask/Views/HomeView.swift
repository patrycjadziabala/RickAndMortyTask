//
//  HomeView.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            Image("galaxy-background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.vertical)
                .opacity(0.9)
            VStack {
                Image("titleImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 350)
                    .padding()
                Text("Press button to load characters list")
                    .font(.custom("Creepster-Regular", size: 23))
                    .padding()
                Button {
                    print("")
                } label: {
                    NavigationLink(destination: CharactersListView()) {
                        Text("Press here")
                            .font(.custom("Creepster-Regular", size: 20))
                            .foregroundColor(.black)
                            .shadow(radius: 1)
                    }
                }
                .padding([.top, .bottom, .leading, .trailing], 3)
                .padding([.leading, .trailing])
                .background(
                    Capsule()
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(.black)
                        .shadow(radius: 1)
                )
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
