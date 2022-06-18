//
//  AppConfiguration.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.06.2022.
//

import Foundation

// MARK: - TASK 1.1 iosdt
enum AppConfiguration: String {
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
}

extension AppConfiguration: CaseIterable {

    static func randomCase() -> String {
        AppConfiguration.allCases.randomElement()?.rawValue ?? "Error"
    }

}
