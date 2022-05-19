//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Руслан Магомедов on 14.05.2022.
//

import Foundation
import UIKit

final class ProfileCoordinator {
    
    func showModel(navigation: UINavigationController? ,coordinator: ProfileCoordinator) {
        let viewModel = ProfileViewModel()
        let profile = ProfileViewController(coordinator: coordinator, viewModel: viewModel)
        navigation?.pushViewController(profile, animated: true)
    }


}
