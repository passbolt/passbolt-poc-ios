import Foundation
import AuthenticationServices

class AutofillCredentialIdentitiesProvider {

    func provideCredentialIdentities() -> [ASPasswordCredentialIdentity] {
        let firstIdentity = ASPasswordCredentialIdentity(
            serviceIdentifier: ASCredentialServiceIdentifier(identifier: "apple.com", type: .domain),
            user: "wojciech.piwonski+apple@polidea.com",
            recordIdentifier: "first")
        let secondIdentity = ASPasswordCredentialIdentity(
            serviceIdentifier: ASCredentialServiceIdentifier(identifier: "strava.com", type: .domain),
            user: "wojciech.piwonski+strava@polidea.com",
            recordIdentifier: "second")
        return [firstIdentity, secondIdentity]
    }
}
