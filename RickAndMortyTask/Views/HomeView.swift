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
            VStack {
                Image("titleImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 350)
                    .padding()
                Text("Press button to load characters list")
                    .font(.custom("Creepster-Regular", size: 20))
                    .padding()
                Button {
                    print("")
                } label: {
                    NavigationLink(destination: CharactersListView()) {
                        Text("Press here")
                            .font(.custom("Creepster-Regular", size: 15))
                            .foregroundColor(.black)
                            .shadow(radius: 1)
                    }
                }
                .padding([.top, .bottom, .leading, .trailing], 2)
                .padding([.leading, .trailing])
                .background(
                    Capsule()
                        .strokeBorder(lineWidth: 2)
                        .foregroundColor(.black)
                        .shadow(radius: 1)
                )
            }
        }
       
//        .background(
//        Image("galaxy-background")
//            .resizable()
//            .scaledToFill()
//        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
