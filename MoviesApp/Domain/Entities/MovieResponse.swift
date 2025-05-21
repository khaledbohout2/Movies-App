//
//  MovieResponse.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?

    // Local-only property (not part of API response)
    var isInWatchlist: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }

    var releaseYear: String? {
        guard let date = releaseDate, !date.isEmpty else { return nil }
        return String(date.prefix(4))
    }

}
