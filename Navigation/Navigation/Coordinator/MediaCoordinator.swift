//
//  MediaCoordinator.swift
//  Navigation
//
//  Created by Руслан Магомедов on 31.05.2022.
//

import Foundation
import UIKit

final class MediaCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?

    func Start() -> UINavigationController? {
        let factory = Factory(state: .media)
        navigationController = factory.startModule(coordinator: self, data: nil)
        
        return navigationController
    }


}
