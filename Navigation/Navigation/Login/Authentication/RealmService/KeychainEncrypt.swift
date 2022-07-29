//
//  KeychainEncrypt.swift
//  Navigation
//
//  Created by Руслан Магомедов on 29.07.2022.
//

import Foundation
import Security


class KeychainEncrypt {
    // ...

    static func save(key: String, data: Data)  {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

            SecItemAdd(query as CFDictionary, nil)
        print("saved")

    }

    static func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

}

