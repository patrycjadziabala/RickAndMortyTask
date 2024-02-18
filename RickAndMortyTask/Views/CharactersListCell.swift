//
//  CharactersListCell.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI
import CachedAsyncImage

struct CharactersListCell: View {
    let character: Character
    @EnvironmentObject var persistanceManager: PersistenceManager
    
    var body: some View {
            VStack (alignment: .leading) {
                HStack {
                    CachedAsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                            .frame(maxWidth: 75, maxHeight: 75)
                            .cornerRadius(45)
                    } placeholder: {
                        ProgressView()
                    }
                    HStack {
                        Text(character.name)
                            .frame(alignment: .trailing)
                        Spacer()
                        if persistanceManager.isPersisted(model: character) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.yellow)
                                .shadow(radius: 1)
                        }
                        Spacer()
                    }
                }
                .scaledToFit()
            }
        }
    }

struct CharactersListCell_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListCell(character: Character(id: 1, name: "", status: "", gender: "", origin: OriginModel(name: "", url: "") , location: LocationModel(name: "", url: "") , image: "", episode: [""]))
    }
}
