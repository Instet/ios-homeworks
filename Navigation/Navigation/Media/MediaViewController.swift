//
//  MediaViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 31.05.2022.
//

import UIKit

class MediaViewController: UIViewController {

    private let coordinator: MediaCoordinator?

    init(coordinator: MediaCoordinator?) {
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
