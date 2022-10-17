//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Руслан Магомедов on 16.10.2022.
//

import Foundation
import LocalAuthentication

protocol LocalAuthorizationProtocol {

    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void)
}

final class LocalAuthorizationService: LocalAuthorizationProtocol {

    private var context = LAContext()
    private var policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics

    private var isUseBiometric: Bool!
    private var error: NSError?
    var typeBiometrics = LAContext().biometryType

    func isAccesBiometric() -> Bool {
        isUseBiometric = context.canEvaluatePolicy(policy, error: &error)
        if let error = error as? LAError {
            print(error.localizedDescription)
        }
        return isUseBiometric!
    }


    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        context.evaluatePolicy(policy, localizedReason: "Предоставьте биометрические данные") { result, error in
            if let error = error  as? LAError {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                authorizationFinished(result)
            }
        }
    }
}
