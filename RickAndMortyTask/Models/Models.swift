//
//  Models.swift
//  RickAndMortyTask
//
//  Created by Patka on 16/02/2024.
//

import Foundation

struct APIModel: Codable {
    let info: InfoModel
    let results: [Character]
}

struct InfoModel: Codable {
    let next: String
    let prev: String?
}

struct Character: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let status: String
    let gender: String
    let origin: OriginModel
    let location: LocationModel
    let image: String
    let episode: [String]
}

struct OriginModel: Codable, Equatable, Hashable {
    let name: String
    let url: String
}

struct LocationModel: Codable, Equatable, Hashable {
    let name: String
    let url: String
}

struct EpisodeModel: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
}
