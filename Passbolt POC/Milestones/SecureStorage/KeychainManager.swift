import Foundation
import Security
import SQLite3
import LocalAuthentication

struct KeychainManager {

    private let context: LAContext

    init() {
        context = LAContext()
        context.touchIDAuthenticationAllowableReuseDuration = 10
    }

    func save(key: String, data: Data) -> OSStatus {
        var error: Unmanaged<CFError>?
        guard let acl = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .userPresence, &error) else {
            return errSecInvalidACL
        }

        let attributes: [String : Any] = [
            kSecClass as String:  kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String : data,
            kSecAttrAccessControl as String : acl,
            kSecUseAuthenticationContext as String: context
        ]
        let status = SecItemAdd(attributes as CFDictionary, nil)
        return status
    }

    func read(key: String) -> Data? {
        var error: Unmanaged<CFError>?
        guard let acl = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .userPresence, &error) else {
            return nil
        }
        let attributes:  [String : Any] = [kSecClass as String: kSecClassGenericPassword as String,
                                           kSecAttrAccount as String: key,
                                           kSecReturnAttributes as String: true,
                                           kSecReturnData as String: true,
                                           kSecAttrAccessControl as String: acl,
                                           kSecUseAuthenticationContext as String: context,
                                           kSecMatchLimit as String: kSecMatchLimitOne]

        var item: AnyObject?

        let status: OSStatus = SecItemCopyMatching(attributes as CFDictionary, &item)

        guard status == errSecSuccess,
              let itemDictionary = item as? [String: Any],
              let data = itemDictionary[kSecValueData as String] as? Data else {
            return nil
        }
        return data
    }

    func delete(key: String) -> OSStatus {
        var error: Unmanaged<CFError>?
        guard let accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .userPresence, &error) else {
            return errSecInvalidACL
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrAccessControl as String: accessControl,
            kSecUseAuthenticationContext as String: context
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status
    }
}
