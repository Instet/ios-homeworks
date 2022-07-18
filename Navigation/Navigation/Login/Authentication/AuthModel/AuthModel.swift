//
//  AuthModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.07.2022.
//

import Foundation
import RealmSwift

final class AuthModel: Object {

    @Persisted var email: String?
    @Persisted var password: String?
    @Persisted var isLogined: Bool
    // пока не придумал

    convenience init(email: String, password: String, isLogined: Bool) {
        self.init()
        self.email = email
        self.password = password
        self.isLogined = isLogined

    }

}
