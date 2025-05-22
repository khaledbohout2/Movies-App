//
//  UICollectionView+forceDequeueCell.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 23/05/2025.
//

import UIKit

extension UICollectionView {
    func forceDequeueCell<T: UICollectionViewCell>(identifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
