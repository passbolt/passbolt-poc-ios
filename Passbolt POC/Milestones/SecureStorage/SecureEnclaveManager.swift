import Foundation
import Security

class SecureEnclaveManager {

    func makeAndStoreKey(name: String,
                         requiresBiometry: Bool = false) throws -> SecKey {

        let flags: SecAccessControlCreateFlags = requiresBiometry ?
            [.privateKeyUsage, .userPresence] : .privateKeyUsage
        let accessControl =
            SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                flags,
                nil)!
        let tag = name.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecAttrKeyType as String           : kSecAttrKeyTypeECSECPrimeRandom,
            kSecAttrKeySizeInBits as String     : 256,
            kSecAttrTokenID as String           : kSecAttrTokenIDSecureEnclave,
            kSecPrivateKeyAttrs as String : [
                kSecAttrIsPermanent as String       : true,
                kSecAttrApplicationTag as String    : tag,
                kSecAttrAccessControl as String     : accessControl
            ]
        ]

        var error: Unmanaged<CFError>?
        guard let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }

        return privateKey
    }

    func loadKey(name: String) -> SecKey? {
        let tag = name.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecClass as String                 : kSecClassKey,
            kSecAttrApplicationTag as String    : tag,
            kSecAttrKeyType as String           : kSecAttrKeyTypeECSECPrimeRandom,
            kSecReturnRef as String             : true
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(attributes as CFDictionary, &item)
        guard status == errSecSuccess else {
            return nil
        }
        return (item as! SecKey)
    }

    func deleteKey(name: String) -> OSStatus {
        let tag = name.data(using: .utf8)!
        let attributes: [String: Any] = [
            kSecClass as String                 : kSecClassKey,
            kSecAttrApplicationTag as String    : tag
        ]
        let status = SecItemDelete(attributes as CFDictionary)
        return status
    }
}
