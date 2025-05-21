//
//  UIImage+Load.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(from posterPath: String) {
        let trimmedPath = posterPath.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedPath.isEmpty else {
            self.image = nil
            return
        }

        let baseImageUrl = "https://image.tmdb.org/t/p/w500"
        let fullUrlString = baseImageUrl + trimmedPath
        
        if let url = URL(string: fullUrlString) {
            self.kf.setImage(with: url)
        } else {
            self.image = nil
        }
    }
}

