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

struct Character: Identifiable, Codable {
    let id: Int
    let name : String
    let status: String
    let gender: String
    let origin: OriginModel
    let location: LocationModel
    let image: String
}

struct OriginModel: Codable {
    let name: String
    let url: String
}

struct LocationModel: Codable {
    let name: String
    let url: String
}
