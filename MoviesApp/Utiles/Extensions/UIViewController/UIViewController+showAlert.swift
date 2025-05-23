import UIKit

extension UIViewController {
    func showSelfDismissingAlert(_ message: String?,
                                 time: TimeInterval = 1) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        alert.title = title
        alert.message = message

        present(alert, animated: true)

        Timer.scheduledTimer(withTimeInterval: time, repeats: false) { timer in
            timer.invalidate()
            alert.dismiss(animated: true)
        }
    }
}
