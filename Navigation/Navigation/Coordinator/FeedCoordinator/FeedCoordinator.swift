//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Руслан Магомедов on 14.05.2022.
//

import Foundation
import UIKit

final class FeedCoordinator {

    func showModel(coordinator: FeedCoordinator) -> UIViewController {
        let viewModel = FeedViewModel()
        let profile = FeedViewController(coordinator: coordinator, viewModel: viewModel)
        profile.title = "Feed"
        profile.view.backgroundColor = .white
        return profile
    }

}
