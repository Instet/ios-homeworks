//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 17.05.2022.
//

import Foundation
import UIKit

protocol FeedViewModelProtocol: AnyObject {

    func setupConstraints(controller: UIViewController, stackView: UIStackView, labelPasswordCheck: UILabel)

    func notify(controller: UINavigationController)

}

final class FeedViewModel: FeedViewModelProtocol {

    var callback: (() -> ())?

    func notify(controller: UINavigationController) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(examinationPasswordTrue), name: Notification.Name("true"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(examinationPasswordFalse), name: Notification.Name("false"), object: nil)
    }

    func setupConstraints(controller: UIViewController, stackView: UIStackView, labelPasswordCheck: UILabel) {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.widthAnchor, constant: -32),

            labelPasswordCheck.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            labelPasswordCheck.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }

    @objc func examinationPasswordTrue() {
        

    }

    @objc func examinationPasswordFalse() {
        
    }

    
}
