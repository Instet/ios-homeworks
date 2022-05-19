//
//  InfoViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 13.02.2022.
//

import UIKit

class InfoViewController: UIViewController {

    var buttonAlert = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        buttonAlert = UIButton(frame: CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50))
        buttonAlert.autoresizingMask = .init(arrayLiteral: [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin])
        buttonAlert.setTitle("Info", for: .normal)
        buttonAlert.addTarget(self, action: #selector(alertMessage), for: .touchUpInside)
        buttonAlert.backgroundColor = .black
        buttonAlert.setTitleColor(.yellow, for: .normal)
        buttonAlert.layer.cornerRadius = 10
        view.addSubview(buttonAlert)

    }

    @objc func alertMessage() {
        let alert = UIAlertController(title: "Attention", message: "More information?", preferredStyle: .alert)

        let yes = UIAlertAction(title: "Yes", style: .default) { _ in
            print("Информация получена")
        }
        let no = UIAlertAction(title: "No", style: .cancel) { _ in
            print("Дополнительная информация не требуется")
        }

        alert.addAction(yes)
        alert.addAction(no)

        self.present(alert, animated: true, completion: nil)

        

    }

}
