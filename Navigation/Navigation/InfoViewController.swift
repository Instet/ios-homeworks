//
//  InfoViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 13.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private let coordinator: InfoCoordinator?
    private let viewModel: InfoViewModel?

    init(coordinator: InfoCoordinator?,
         viewModel: InfoViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var buttonAlert: ButtonAlert = {
        let button = ButtonAlert(title: "Info", titleColor: .white) { [ weak self ] in
            guard let self = self else { return }
            self.pressButton()
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubviews(buttonAlert)
        viewModel?.setupConstraints(controller: self, button: buttonAlert)

    }

    func pressButton() {
        viewModel?.presentAlert(controller: self)
    }

}
