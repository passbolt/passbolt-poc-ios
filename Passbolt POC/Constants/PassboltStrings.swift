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

    enum AutofillTest {
        static let title = "AutoFill POC"
        static let checkAutoFillStatusButton = "Check AutoFill status"
        static let openAppleWebsiteButton = "Open Apple site"
        static let openStravaApp = "Open Strava app"
    }

    enum SecureStorage {
        static let title = "Secure storage POC"

        static let useFirstKeyButton = "Use key 1"
        static let useSecondKeyButton = "Use key 2"
        static let publicKeyLabel = "Public key"
        static let privateKeyLabel = "Private key"
        static let passwordLabel = "Password"
        static let clearUI = "Clear UI"
        static let readKeysButton = "Read keys"
        static let saveKeysButton = "Save keys"
        static let clearStorageButton = "Clear encrypted storage"

        static let saveToKeychainButton = "Save to Keychain"
        static let readFromKeychainButton = "Read from Keychain"
        static let deleteFromKeychainButton = "Delete from Keychain"

        static let createKeyInSE = "Create key in SE"
        static let loadKeyFromSE = "Load key from SE"
        static let deleteKeyFromSE = "Delete key from SE"

        static let encryptDataButton = "Encrypt data"
        static let decryptDataButton = "Decrypt data"
    }
}
