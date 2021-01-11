import UIKit
import CryptoKit
import Security

enum SecureStorageKey: String {
    case privateKey
    case publicKey
    case password
}

class SecureStorageViewController: UIViewController {

    var customView: SecureStorageView {
        return view as! SecureStorageView
    }

    private let secureEnclaveManager = SecureEnclaveManager()

    private let keychainManager = KeychainManager()

    private var privateKey: SecKey? = nil

    private var cipherTextData: Data? = nil

    override func loadView() {
        view = SecureStorageView()
        self.title = PassboltStrings.SecureStorage.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        customView.useFirstKeyButton.addTarget(
            self, action: #selector(useFirstKeyButtonClicked), for: .touchUpInside
        )
        customView.useSecondKeyButton.addTarget(
            self, action: #selector(useSecondKeyButtonClicked), for: .touchUpInside
        )
        customView.clearUIButton.addTarget(
            self, action: #selector(clearUIButtonClicked), for: .touchUpInside
        )
        customView.readKeysButton.addTarget(
            self, action: #selector(readKeysButtonClicked), for: .touchUpInside
        )
        customView.saveKeysButton.addTarget(
            self, action: #selector(saveKeysButtonClicked), for: .touchUpInside
        )
        customView.clearStorageButton.addTarget(
            self, action: #selector(clearStorageButtonClicked), for: .touchUpInside
        )
        customView.saveToKeychainButton.addTarget(
            self, action: #selector(saveToKeychainButtonClicked), for: .touchUpInside
        )
        customView.readFromKeychainButton.addTarget(
            self, action: #selector(readFromKeychainButtonClicked), for: .touchUpInside
        )
        customView.deleteFromKeychainButton.addTarget(
            self, action: #selector(deleteFromKeychainButtonClicked), for: .touchUpInside
        )
        customView.createKeyInSEButton.addTarget(
            self, action: #selector(createKeyInSEButtonClicked), for: .touchUpInside
        )
        customView.loadKeyFromSEButton.addTarget(
            self, action: #selector(loadKeyFromSEButtonClicked), for: .touchUpInside
        )
        customView.deleteKeyFromSEButton.addTarget(
            self, action: #selector(deleteKeyFromSEButtonClicked), for: .touchUpInside
        )
        customView.encryptDataButton.addTarget(
            self, action: #selector(encryptDataButtonClicked), for: .touchUpInside
        )
        customView.decryptDataButton.addTarget(
            self, action: #selector(decryptDataButtonClicked), for: .touchUpInside
        )
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

    @objc private func clearUIButtonClicked() {
        customView.publicKeyTextView.text = ""
        customView.privateKeyTextView.text = ""
        customView.passwordTextView.text = ""
    }

    @objc private func readKeysButtonClicked() {
        guard let keyData = keychainManager.read(key: "keyData"),
              let keyDictionary = try? JSONDecoder().decode(Dictionary<String, Data>.self, from: keyData) else {
            showToast(message: "Can't decode key dictionary")
            return
        }
        guard let publicKeyData = keyDictionary[SecureStorageKey.publicKey.rawValue],
              let privateKeyData = keyDictionary[SecureStorageKey.privateKey.rawValue],
              let passwordData = keyDictionary[SecureStorageKey.password.rawValue],
              let publicKey = String(data: publicKeyData, encoding: .utf8),
              let privateKey = String(data: privateKeyData, encoding: .utf8),
              let password = String(data: passwordData, encoding: .utf8) else {
            showToast(message: "Read error")
            return
        }
        customView.publicKeyTextView.text = publicKey
        customView.privateKeyTextView.text = privateKey
        customView.passwordTextView.text = password
    }

    @objc private func saveKeysButtonClicked() {
        guard let publicKey = customView.publicKeyTextView.text.data(using: .utf8),
              let privateKey = customView.privateKeyTextView.text.data(using: .utf8),
              let password = customView.passwordTextView.text.data(using: .utf8) else {
            return
        }
        let keyDictionary = [
            SecureStorageKey.publicKey.rawValue: publicKey,
            SecureStorageKey.privateKey.rawValue: privateKey,
            SecureStorageKey.password.rawValue: password
        ]
        let encoder = JSONEncoder()
        guard let keyData = try? encoder.encode(keyDictionary) else {
            showToast(message: "Can't encode key dictionary")
            return
        }
        let status = keychainManager.save(key: "keyData", data: keyData)
        if status == errSecSuccess {
            showToast(message: "Keys saved in Keychain")
        } else {
            showToast(message: "Saving error: :\(status)")
        }
    }

    @objc private func clearStorageButtonClicked() {
        let status = keychainManager.delete(key: "keyData")
        if status == errSecSuccess {
            showToast(message: "Storage cleared")
        } else {
            showToast(message: "Clear error: \(status)")
        }
    }

    @objc private func useFirstKeyButtonClicked() {
        customView.privateKeyTextView.text = PassboltKeys.privateKey1.rawValue
        customView.publicKeyTextView.text = PassboltKeys.publicKey1.rawValue
        customView.passwordTextView.text = PassboltKeys.privateKey1Password.rawValue
    }

    @objc private func useSecondKeyButtonClicked() {
        customView.privateKeyTextView.text = PassboltKeys.privateKey2.rawValue
        customView.publicKeyTextView.text = PassboltKeys.publicKey2.rawValue
        customView.passwordTextView.text = PassboltKeys.privateKey2Password.rawValue
    }


    @objc private func saveToKeychainButtonClicked() {
        guard let data = "Sample Data".data(using: .utf8) else {
            return
        }
        let status = keychainManager.save(key: "sampleKey", data: data)
        if status == errSecSuccess {
            showToast(message: "Data has been saved")
        } else {
            showToast(message: "Saving error: \(status)")
        }
    }

    @objc private func readFromKeychainButtonClicked() {
        if let data = keychainManager.read(key: "sampleKey"),
           let message = String(data: data, encoding: .utf8) {
            showToast(message: message)
        } else {
            showToast(message: "Read error")
        }
    }

    @objc private func deleteFromKeychainButtonClicked() {
        let status = keychainManager.delete(key: "sampleKey")
        if status == errSecSuccess {
            showToast(message: "Data has been deleted")
        } else {
            showToast(message: "Delete error: \(status)")
        }
    }

    @objc private func createKeyInSEButtonClicked() {
        do {
            let privateKey = try secureEnclaveManager.makeAndStoreKey(name: "secureEnclaveKey", requiresBiometry: true)
            showToast(message: "Private key created: \(privateKey.hashValue)")
            self.privateKey = privateKey
        } catch {
            showToast(message: "Creation error: \(error.localizedDescription)")
            print("Creation error: \(error.localizedDescription)")
        }
    }

    @objc private func loadKeyFromSEButtonClicked() {
        if let privateKey = secureEnclaveManager.loadKey(name: "secureEnclaveKey") {
            showToast(message: "Private key loaded: \(privateKey.hashValue)")
            self.privateKey = privateKey
        } else {
            showToast(message: "Private key not found")
            print("Private key not found")
        }
    }

    @objc private func deleteKeyFromSEButtonClicked() {
        let status = secureEnclaveManager.deleteKey(name: "secureEnclaveKey")
        if status == errSecSuccess {
            showToast(message: "Key has been deleted from SE")
        } else {
            showToast(message: "Delete error: \(status)")
        }
    }

    @objc private func encryptDataButtonClicked() {
        guard let privateKey = self.privateKey else {
            showToast(message: "No private key")
            return
        }
        guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
            // Can't get public key
            showToast(message: "Can't get public key")
            return
        }
        let algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorVariableIVX963SHA256AESGCM
        guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, algorithm) else {
            // Algorith not supported
            showToast(message: "Algorithm not supported")
            return
        }
        // Now we're ready to encrypt data using publicKey

        let clearText = "Sample Data"

        var error: Unmanaged<CFError>?
        let clearTextData = clearText.data(using: .utf8)!
        guard let cipherTextData = SecKeyCreateEncryptedData(publicKey, algorithm,
            clearTextData as CFData,
            &error) as Data? else {
            let errorDescription = (error!.takeRetainedValue() as Error).localizedDescription
            showToast(message: "Can't encrypt: \(errorDescription)")
            print("Can't encrypt: \(errorDescription)")
            return
        }
        self.cipherTextData = cipherTextData
        showToast(message: "Data encrypted")
        print("Data encrypted: \(cipherTextData.base64EncodedString())")
//        guard let accessControl =
//        SecAccessControlCreateWithFlags(kCFAllocatorDefault,
//            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
//            .privateKeyUsage,
//            nil) else {
//            return
//        }
//        let attributes: [String: Any] = [
//            kSecAttrKeyType as String:            kSecAttrKeyTypeECSECPrimeRandom,
//            kSecAttrKeySizeInBits as String:      256,
//            kSecAttrTokenID as String:            kSecAttrTokenIDSecureEnclave,
//            kSecPrivateKeyAttrs as String: [
//                kSecAttrIsPermanent as String:      true,
//                kSecAttrApplicationTag as String:   "com.passbolt.poc",
//                kSecAttrAccessControl as String:    accessControl
//            ]
//        ]
//
//        guard let privateKey = try? SecureEnclave.P256.Signing.PrivateKey(
//                  accessControl: accessControl)
//            else {
//            return
//        }
//
//        guard
//            let eCCPrivKey = SecKeyCreateRandomKey(attributes as CFDictionary, nil) else {
//            print("ECC KeyGen Error!")
//            return
//        }
//
//        guard
//            let eCCPubKey = SecKeyCopyPublicKey(eCCPrivKey) else {
//            print("ECC Pub KeyGen Error")
//            return
//        }
//        eCCPrivKey.re
    }

    @objc private func decryptDataButtonClicked() {
        guard let privateKey = self.privateKey else {
            showToast(message: "No private key")
            return
        }
        guard let cipherTextData = self.cipherTextData else {
            showToast(message: "No encrypted data")
            return
        }

        let algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorVariableIVX963SHA256AESGCM
        guard SecKeyIsAlgorithmSupported(privateKey, .decrypt, algorithm) else {
            showToast(message: "Algorithm not supported")
            return
        }

        // SecKeyCreateDecryptedData call is blocking when the used key
        // is protected by biometry authentication. If that's not the case,
        // dispatching to a background thread isn't necessary.
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            var error: Unmanaged<CFError>?
            let clearTextData = SecKeyCreateDecryptedData(privateKey,
                algorithm,
                cipherTextData as CFData,
                &error) as Data?
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                guard clearTextData != nil else {
                    let errorDescription = (error!.takeRetainedValue() as Error).localizedDescription
                    self.showToast(message: "Can't decrypt: \(errorDescription)")
                    print("Can't decrypt: \(errorDescription)")
                    return
                }
                let clearText = String(decoding: clearTextData!, as: UTF8.self)
                // clearText is our decrypted string
                self.showToast(message: clearText)
            }
        }
    }

}
