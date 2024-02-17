//
//  EpisodeDetailsView.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: EpisodeModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("Name")
                        Text("Air date")
                        Text("Episode")
                    }
                    Divider()
                        .foregroundColor(.gray)
                }
                VStack {
                    Text(episode.name)
                    Text(episode.air_date)
                    Text(episode.episode)
                }
//                ForEach(episode.characters) { character in
//                    Text("")
//                }
            }
           
        }
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(episode: EpisodeModel(id: 1, name: "", air_date: "", episode: "", characters: [""]))
    }
}
