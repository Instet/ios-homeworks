//
//  InfoViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.05.2022.
//

import Foundation
import UIKit

final class InfoViewModel {


    var alert: UIAlertController {
        let alert = UIAlertController(title: "Attention", message: "More information?", preferredStyle: .alert)

        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            print("Информация получена")
        }
        let no = UIAlertAction(title: "No", style: .cancel) { _ in
            print("Дополнительная информация не требуется")
        }

        alert.addAction(yes)
        alert.addAction(no)

        return alert

    }

    func presentAlert(controller: UIViewController) {
        controller.present(alert, animated: true)
    }

    func setupConstraints(controller: UIViewController, button: UIButton) {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
    }
}
