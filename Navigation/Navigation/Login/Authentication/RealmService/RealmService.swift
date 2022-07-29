//
//  RealmService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.07.2022.
//

import Foundation
import RealmSwift
import KeychainAccess

final class RealmService{

    static let shared = RealmService()

    func getKey() -> Data {
        let keychain = Keychain(service: "MyNetology")

        do {
            if let key = try keychain.getData("MyRealm") {
                return key
            } else {
                var key = Data(count: 64)
                _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
                    SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)}
                try keychain.set(key, key: "MyRealm")
                return key
            }
        } catch {
            fatalError()
        }
    }
    

    private func getConfig() -> Realm.Configuration {
        let key = getKey()
        let config = Realm.Configuration(encryptionKey: key)
        return config
    }

    func fetch() -> Results<AuthModel>?{
        let realm = try? Realm(configuration: getConfig())
        print("Получаем объект ⚠️ \(String(describing: realm?.objects(AuthModel.self)))")
        return realm?.objects(AuthModel.self)
    }

    func save(_ model: AuthModel) {
        do {
            let realm = try Realm(configuration: getConfig())
            try realm.write({
                realm.add(model)
                print("⚠️ \(realm.configuration.fileURL?.absoluteURL as Any)")
            })

        } catch  {
            print(error.localizedDescription)

        }
    }

    func deleteUser(_ model: AuthModel) {
        do {
            let realm = try Realm(configuration: getConfig())
            try realm.write({
                realm.delete(model)

            })

        } catch  {
            print(error.localizedDescription)

        }
        
    }



}
