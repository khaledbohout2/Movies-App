//
//  UITableView.swift
//  MoviesApp
//
//  Created by Khaled-Circle on 21/05/2025.
//

import UIKit

extension UITableView {
    func forceDequeueCell<T: UITableViewCell>(identifier: String) -> T {
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
