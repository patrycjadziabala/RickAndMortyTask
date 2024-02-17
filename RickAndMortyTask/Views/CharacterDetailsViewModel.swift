//
//  CharacterDetailsViewModel.swift
//  RickAndMortyTask
//
//  Created by Patka on 17/02/2024.
//

import Foundation

class CharacterDetailsViewModel: ObservableObject {
    let character: Character
    
    init(character: Character) {
        self.character = character
    }

    func getEpisodeNumberFromEpisodeUrl(url: String) -> Int? {
        let episodeNumber = url.components(separatedBy: "/").last
        return Int(episodeNumber ?? "")
    }
    
    func getEpisodeNumberString(url: String) -> String? {
        guard let episodeNumber = getEpisodeNumberFromEpisodeUrl(url: url) else {
            return nil
        }
        let episodeNumberString = "\(episodeNumber)"
        return episodeNumberString
    }
}
