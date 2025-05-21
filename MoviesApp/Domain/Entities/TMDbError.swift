//
//  TMDbError.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import Foundation

struct TMDbError: Decodable, Error {
    let status_code: Int
    let status_message: String
    let success: Bool?

    var localizedDescription: String {
        return status_message
    }
}
