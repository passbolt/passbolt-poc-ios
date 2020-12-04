import Foundation

enum PassboltStrings {

    enum Main {
        static let title = "Passbolt POC"
    }

    enum Encrypt {
        static let title = "Encryption library POC"
    }

    enum EncryptDecrypt {
        static let title = "Encrypt/Decrypt POC"
        static let messageLabel = "Message"
        static let messageTextViewPlaceholder = "Paste or enter a message you want to encrypt or decrypt."
        static let keysInfoLabel = "The keys are rsa3072 keys and were generated using gpg tool on MacOS."
        static let privateKeyButton = "Private key"
        static let publicKeyButton = "Public key"
        static let keyLabel = "Key"
        static let keyTextViewPlaceholder = "Paste or enter a public or private gpg key or use one of the buttons to fill this field with a predefined public or private key."
        static let passwordLabel = "Password"
        static let encryptButton = "Encrypt"
        static let decryptButton = "Decrypt"
        static let resultLabel = "Result"
        static let operationTime = "Operation took %.0f milliseconds"
    }

    enum SignVerify {
        static let title = "Sign/Verify POC"
        static let messageLabel = "Message"
        static let messageTextViewPlaceholder = "Paste or enter a message you want to encrypt or decrypt."
        static let keysInfoLabel = "The keys are rsa3072 keys and were generated using gpg tool on MacOS."
        static let useFirstKeyLabel = "Use Key 1"
        static let useSecondKeyLabel = "Use Key 2"
        static let privateKeyButton = "Private key"
        static let publicKeyButton = "Public key"
        static let keyLabel = "Key"
        static let keyTextViewPlaceholder = "Paste or enter a public or private gpg key or use one of the buttons to fill this field with a predefined public or private key."
        static let passwordLabel = "Password"
        static let signButton = "Sign"
        static let verifyButton = "Verify"
        static let resultLabel = "Result"
        static let operationTime = "Operation took %.0f milliseconds"
    }
}
