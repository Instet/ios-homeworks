//
//  FeedViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    let post = Post(title: "Post")

    let firstButton: UIButton = {
        let firstButton = UIButton()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.setTitle("First Button", for: .normal)
        firstButton.backgroundColor = .black
        firstButton.setTitleColor(.yellow, for: .normal)
        firstButton.layer.cornerRadius = 10
        firstButton.addTarget(nil, action: #selector(tapButtons), for: .touchUpInside)
        return firstButton
    }()

    let secondButton: UIButton = {
        let secondButton = UIButton()
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.setTitle("Second Button", for: .normal)
        secondButton.backgroundColor = .black
        secondButton.setTitleColor(.yellow, for: .normal)
        secondButton.layer.cornerRadius = 10
        secondButton.addTarget(nil, action: #selector(tapButtons), for: .touchUpInside)
        return secondButton
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .yellow
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.distribution = .fillEqually
        return stackView
    }()

    private func setupConstraintsStackView() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed"
        self.view.addSubviews(stackView)
        setupConstraintsStackView()

    }

    override func viewWillAppear(_ animated: Bool) {
        print("будет скрыт таббар и открыта страница пост")
        tabBarController?.tabBar.isHidden = false
    }

    @objc func tapButtons() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
        postVC.postTitle = post.title
        tabBarController?.tabBar.isHidden = true
    }


}
