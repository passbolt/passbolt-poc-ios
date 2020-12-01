import Foundation
import UIKit
import Gopenpgp

class MainViewController: UIViewController {

    override func loadView() {
        view = MainView()
        self.title = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let message = "Hello world!"
        let password = "Passbolt#"
        if let passwordData = password.data(using: .utf8) {
            let encryptedMessage = HelperEncryptMessageWithPassword(passwordData, message, nil)
            let text = """
                       Encrypted message:
                       \(encryptedMessage)

                       Decrypted message:
                       \(message)
                       """
            (view as? MainView)?.setLabelText(text: text)
        }
    }
}
