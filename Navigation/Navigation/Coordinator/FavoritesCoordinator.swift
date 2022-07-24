//
//  FavoritesCoordinator.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.07.2022.
//

import Foundation
import UIKit

class FavoritesCoordinator: CoordinatorViewController {

    var navigationController: UINavigationController?

    func Start()  -> UINavigationController? {
        let factory = Factory(state: .favoritesPost)
        navigationController = factory.startModule(coordinator: self, data: nil)
        return navigationController
    }


}
