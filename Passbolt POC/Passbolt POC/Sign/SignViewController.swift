import Foundation
import UIKit
import Gopenpgp

class SignViewController: UIViewController {

    var customView: SignView {
        return view as! SignView
    }

    override func loadView() {
        view = SignView()
        self.title = PassboltStrings.Sign.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        customView.privateKeyButton.addTarget(self, action: #selector(privateButtonClicked), for: .touchUpInside)
        customView.publicKeyButton.addTarget(self, action: #selector(publicButtonClicked), for: .touchUpInside)
        customView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        customView.verifyButton.addTarget(self, action: #selector(verifyButtonClicked), for: .touchUpInside)
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
        let (key, password) = customView.keySwitch.isOn
            ? (PassboltKeys.privateKey2, PassboltKeys.privateKey2Password)
            : (PassboltKeys.privateKey1, PassboltKeys.privateKey1Password)
        customView.keyTextView.text = key.rawValue
        customView.passwordTextView.text = password.rawValue
    }

    @objc func publicButtonClicked() {
        let key = customView.keySwitch.isOn ? PassboltKeys.publicKey2.rawValue : PassboltKeys.publicKey1.rawValue
        customView.keyTextView.text = key
        customView.passwordTextView.text = ""
    }

    @objc func signButtonClicked() {
        let message = customView.messageTextView.text
        let key = customView.keyTextView.text
        let password = customView.passwordTextView.text.data(using: .utf8)
        var error: NSError?
        let signed = HelperSignCleartextMessageArmored(key, password, message, &error)
        if let error = error {
            showError(error: error)
        } else {
            customView.resultTextView.text = signed
        }
    }

    @objc func verifyButtonClicked() {
        let message = customView.messageTextView.text
        let key = customView.keyTextView.text
        var error: NSError?
        let verified = HelperVerifyCleartextMessageArmored(key, message, CryptoGetUnixTime(), &error)
        if let error = error {
            showError(error: error)
        } else {
            customView.resultTextView.text = verified
        }
    }

    private func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
