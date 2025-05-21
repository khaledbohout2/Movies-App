//
//  MovieResponse.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 20/05/2025.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
    }

}

struct Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?

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
