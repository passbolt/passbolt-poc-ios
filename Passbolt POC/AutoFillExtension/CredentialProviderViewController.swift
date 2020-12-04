//
//  CredentialProviderViewController.swift
//  AutoFillExtension
//
//  Created by Wojciech Piwoński on 12/8/20.
//

import AuthenticationServices
import Gopenpgp

class CredentialProviderViewController: ASCredentialProviderViewController {

    /*
     Prepare your UI to list available credentials for the user to choose from. The items in
     'serviceIdentifiers' describe the service the user is logging in to, so your extension can
     prioritize the most relevant credentials in the list.
    */
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
        print("prepareCredentialList: \(serviceIdentifiers)")
    }

    /*
     Implement this method if your extension supports showing credentials in the QuickType bar.
     When the user selects a credential from your app, this method will be called with the
     ASPasswordCredentialIdentity your app has previously saved to the ASCredentialIdentityStore.
     Provide the password by completing the extension request with the associated ASPasswordCredential.
     If using the credential would require showing custom UI for authenticating the user, cancel
     the request with error code ASExtensionError.userInteractionRequired.
    */

    override func provideCredentialWithoutUserInteraction(for credentialIdentity: ASPasswordCredentialIdentity) {
        let databaseIsUnlocked = true
        if (databaseIsUnlocked) {
            let password = getDecryptedPassword()
            let passwordCredential = ASPasswordCredential(
                user: credentialIdentity.user,
                password: password
            )
            self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
        } else {
            self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code:ASExtensionError.userInteractionRequired.rawValue))
        }
    }

    /*
     Implement this method if provideCredentialWithoutUserInteraction(for:) can fail with
     ASExtensionError.userInteractionRequired. In this case, the system may present your extension's
     UI and call this method. Show appropriate UI for authenticating the user then provide the password
     by completing the extension request with the associated ASPasswordCredential.
    */

    override func prepareInterfaceToProvideCredential(for credentialIdentity: ASPasswordCredentialIdentity) {
    }

    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }

    @IBAction func passwordSelected(_ sender: AnyObject?) {
        let password = getDecryptedPassword()
        let passwordCredential = ASPasswordCredential(
            user: "wojciech.piwonski+from_ui@polidea.com",
            password: password
        )
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }

    private func getDecryptedPassword() -> String {
        var error: NSError?
        let key = PassboltKeys.privateKey1.rawValue
        let password = PassboltKeys.privateKey1Password.rawValue.data(using: .utf8)
        let message = PassboltKeys.autoFillEncryptedPassword.rawValue
        let decrypted = HelperDecryptMessageArmored(key, password, message, &error)
        guard error == nil else {
            return ""
        }
        return decrypted
    }

}
