//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.05.2022.
//

import Foundation
import UIKit

final class InfoCoordinator {

    func push(controller: UINavigationController?, coordinator: InfoCoordinator) {
        let vieModel = InfoViewModel()
        let viewController = InfoViewController(coordinator: coordinator, viewModel: vieModel)
        viewController.view.backgroundColor = .systemGray5
        controller?.present(viewController, animated: true)
        


    }
}
