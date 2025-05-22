//
//  MovieCreditsResponse.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import Foundation

struct MovieCreditsResponse: Codable {
    let id: Int
    let cast: [CastMember]
    let crew: [CrewMember]
}

struct CastMember: Codable, Identifiable {
    let id: Int
    let name: String
    let popularity: Double
    let knownForDepartment: String

    enum CodingKeys: String, CodingKey {
        case id, name, popularity
        case knownForDepartment = "known_for_department"
    }
}

struct CrewMember: Codable, Identifiable {
    let id: Int
    let name: String
    let popularity: Double
    let knownForDepartment: String
    let job: String

    enum CodingKeys: String, CodingKey {
        case id, name, popularity, job
        case knownForDepartment = "known_for_department"
    }
}

struct Cast {
    let actors: [CastMember]
    let directors: [CrewMember]
}
