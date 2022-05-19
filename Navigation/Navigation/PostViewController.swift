//
//  PostViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 13.02.2022.
//

import UIKit

class PostViewController: UIViewController {

    var postTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = postTitle
        var barButton = UIBarButtonItem()
        barButton = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(tapInfo))
        navigationItem.rightBarButtonItem = barButton
        
    }
 
   
    @objc func tapInfo() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)

        
    }



}
