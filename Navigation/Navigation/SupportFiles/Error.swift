//
//  Error.swift
//  Navigation
//
//  Created by Руслан Магомедов on 30.05.2022.
//

import Foundation

enum AuthorizationError: Error {
    case badLogin
    case badPassword
    case badAuthData
}
