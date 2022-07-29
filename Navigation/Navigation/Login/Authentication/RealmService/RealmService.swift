//
//  RealmService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.07.2022.
//

import Foundation
import RealmSwift

final class RealmService{

    static let shared = RealmService()

    private func getConfig() -> Realm.Configuration {
        let key = KeychainEncrypt.getkey()
        let config = Realm.Configuration(encryptionKey: key as Data)
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
