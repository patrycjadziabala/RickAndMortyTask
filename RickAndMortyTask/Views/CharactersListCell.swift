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
        HStack (alignment: .center, spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color(.blue))
                    .opacity(0.6)
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                AsyncImage(url: URL(string: character.image)) { image in
                    image.resizable()
                        .frame(maxWidth: 15, maxHeight: 15)
                } placeholder: {
                    ProgressView()
                }
            }
            Divider()
                .foregroundColor(.gray)
            Spacer()
            Text(character.name)
        }
    }
}

struct CharactersListCell_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListCell(character: Character(id: 1, name: "", status: "", gender: "", origin: OriginModel(name: "", url: "") , location: LocationModel(name: "", url: "") , image: ""))
    }
}
