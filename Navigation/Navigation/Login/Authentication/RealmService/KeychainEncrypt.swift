//
//  KeychainEncrypt.swift
//  Navigation
//
//  Created by Руслан Магомедов on 29.07.2022.
//

import Foundation
import Security


class KeychainEncrypt {

    static func getkey() -> NSData {

        let keychainIdentifier = "MyRealmEncrypt"
        let keychainIdentifierData = keychainIdentifier.data(using: .utf8, allowLossyConversion: false)!

        var query: [NSString: AnyObject] = [
            kSecClass : kSecClassKey,
            kSecAttrApplicationTag : keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits : 512 as AnyObject,
            kSecReturnData : true as AnyObject
        ]

        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary,            UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! NSData
        }

        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")

        query = [
            kSecClass : kSecClassKey,
            kSecAttrApplicationTag : keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits : 512 as AnyObject,
            kSecValueData : keyData
        ]

        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")

        return keyData
    }


}

