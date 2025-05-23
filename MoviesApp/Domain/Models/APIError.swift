//
//  APIError.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 23/05/2025.
//

import Foundation

enum APIError: LocalizedError {
    case badURL
    case authenticationRequired
    case serverError(statusCode: Int, message: String?)
    case decodingError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Invalid URL."
        case .authenticationRequired:
            return "Authentication is required."
        case .serverError(let statusCode, let message):
            return "Server returned error \(statusCode): \(message ?? "Unknown error")"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
