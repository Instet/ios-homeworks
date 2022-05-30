//
//  Errors.swift
//  Navigation
//
//  Created by Руслан Магомедов on 30.05.2022.
//

import Foundation

enum AuthorizationErrors: Error {
    case noLogin
    case noPassword
    case wrongDate
}
