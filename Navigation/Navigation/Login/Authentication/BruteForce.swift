//
//  BruteForce.swift
//  Navigation
//
//  Created by Руслан Магомедов on 22.05.2022.
//

import Foundation

final class BruteForce {

    // MARK: - Task 9

    private let loginInspector: LoginViewControllerDelegate?
    private let login: String
    let actionBruteForce:(_ password: String) -> Void

    init(loginInspector: LoginViewControllerDelegate?,
         login: String,
         actionBruteForce: @escaping (_ password: String) -> Void ) {
        self.loginInspector = loginInspector
        self.login = login
        self.actionBruteForce = actionBruteForce
    }


    func bruteForce() {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""


        if let loginInspector = loginInspector {
            while !loginInspector.check(login: login, password: password) {
                password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                print(password)

            }
        }

        self.actionBruteForce(password)
    }

    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }

    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }

}



extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }



    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}



