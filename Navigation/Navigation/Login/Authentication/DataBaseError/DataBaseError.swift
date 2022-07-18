//
//  DataBaseError.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.07.2022.
//

import Foundation
import RealmSwift

enum DataBaseError: Error {
    case wrongModel
    case error(description: String)
    case unknow
}

