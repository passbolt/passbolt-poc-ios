import Foundation
import UIKit
import Gopenpgp

class EncryptionViewController: UIViewController {

    var customView: EncryptionView {
        return view as! EncryptionView
    }

    override func loadView() {
        view = EncryptionView()
        self.title = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        customView.privateKeyButton.addTarget(self, action: #selector(privateButtonClicked), for: .touchUpInside)
        customView.publicKeyButton.addTarget(self, action: #selector(publicButtonClicked), for: .touchUpInside)
        customView.encryptButton.addTarget(self, action: #selector(encryptButtonClicked), for: .touchUpInside)
        customView.decryptButton.addTarget(self, action: #selector(decryptButtonClicked), for: .touchUpInside)
    }

    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard let keyboardFrame: NSValue =
        notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            customView.updateKeyboardConstraints(keyboardHeight: 0)
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        customView.updateKeyboardConstraints(keyboardHeight: keyboardHeight)
    }

    @objc func privateButtonClicked() {
        customView.keyTextView.text = PassboltKeys.privateKey1.rawValue
        customView.passwordTextView.text = PassboltKeys.privateKey1Password.rawValue
    }

    @objc func publicButtonClicked() {
        customView.keyTextView.text = PassboltKeys.publicKey1.rawValue
        customView.passwordTextView.text = ""
    }

    @objc func encryptButtonClicked() {
        let message = customView.messageTextView.text
        let key = customView.keyTextView.text
        var error: NSError?
        let encrypted = HelperEncryptMessageArmored(key, message, &error)
        if let error = error {
            showError(error: error)
        } else {
            customView.resultTextView.text = encrypted
        }
    }

    @objc func decryptButtonClicked() {
        let message = customView.messageTextView.text
        let key = customView.keyTextView.text
        let password = customView.passwordTextView.text.data(using: .utf8)
        var error: NSError?
        let decrypted = HelperDecryptMessageArmored(key, password, message, &error)
        if let error = error {
            showError(error: error)
        } else {
            customView.resultTextView.text = decrypted
        }
    }

    private func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
