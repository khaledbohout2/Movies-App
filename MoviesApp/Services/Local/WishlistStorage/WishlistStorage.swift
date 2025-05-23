
import Foundation

protocol WishlistStorage {
    func add(movieID: Int)
    func remove(movieID: Int)
    func contains(movieID: Int) -> Bool
    func getAll() -> [Int]
}

final class WishlistManager: WishlistStorage {
    private let key = "wishlist_movie_ids"
    private let defaults = UserDefaults.standard
    private let queue = DispatchQueue(label: "WishlistQueue", qos: .userInitiated)

    func add(movieID: Int) {
        queue.async {
            var ids = self.getAll()
            guard !ids.contains(movieID) else { return }
            ids.append(movieID)
            self.defaults.set(ids, forKey: self.key)
        }
    }

    func remove(movieID: Int) {
        queue.async {
            var ids = self.getAll()
            ids.removeAll { $0 == movieID }
            self.defaults.set(ids, forKey: self.key)
        }
    }

    func getAll() -> [Int] {
        return defaults.array(forKey: key) as? [Int] ?? []
    }

    func contains(movieID: Int) -> Bool {
        return getAll().contains(movieID)
    }
}
