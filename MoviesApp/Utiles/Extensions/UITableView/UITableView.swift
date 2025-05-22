
import UIKit

extension UITableView {
    func forceDequeueCell<T: UITableViewCell>(identifier: String) -> T {
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
