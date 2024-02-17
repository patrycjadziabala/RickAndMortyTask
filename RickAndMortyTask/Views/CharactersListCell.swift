//
//  CharactersListCell.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import SwiftUI

struct CharactersListCell: View {
    let character: Character
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .frame(maxWidth: 75, maxHeight: 75)
                        .cornerRadius(45)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                Spacer()
                Text(character.name)
                    .frame(alignment: .trailing)
            }
            Divider()
                .foregroundColor(.gray)
        }
    }
}

struct CharactersListCell_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListCell(character: Character(id: 1, name: "", status: "", gender: "", origin: OriginModel(name: "", url: "") , location: LocationModel(name: "", url: "") , image: "", episode: [""]))
    }
}
