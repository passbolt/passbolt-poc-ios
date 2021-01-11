import UIKit

extension UIViewController {

    // based on: https://stackoverflow.com/a/35130932/4137318
    func showToast(message: String, font: UIFont = .systemFont(ofSize: 12.0)) {
        let toastLabel = UILabel(frame: CGRect(
            x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height - 100, width: 200, height: 35)
        )
        toastLabel.backgroundColor = UIColor.label.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.systemBackground
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 2.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }