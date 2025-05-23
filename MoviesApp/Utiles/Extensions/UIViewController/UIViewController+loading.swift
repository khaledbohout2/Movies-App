
import UIKit

private var spinnerKey: UInt8 = 0

extension UIViewController {
    private var spinner: UIActivityIndicatorView? {
        get { objc_getAssociatedObject(self, &spinnerKey) as? UIActivityIndicatorView }
        set { objc_setAssociatedObject(self, &spinnerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func startLoading() {
        guard spinner == nil else { return }

        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        spinner.startAnimating()

        view.addSubview(spinner)
        self.spinner = spinner
    }

    func stopLoading() {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        spinner = nil
    }
}
