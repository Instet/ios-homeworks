//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.07.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    private let coordinator: FavoritesCoordinator?

    init(coordinator: FavoritesCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


}
