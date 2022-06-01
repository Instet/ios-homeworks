//
//  MediaViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 31.05.2022.
//

import UIKit
import AVFoundation
import AVKit

class AudioViewController: UIViewController {

    private let coordinator: AudioCoordinator?
    private let viewModel: AudioViewModel?
    var videoArray: [(name: String, url: URL)] = []


    lazy var mediaTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        return table
    }()

    init(coordinator: AudioCoordinator?,
         viewModel: AudioViewModel?) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Media"
        mediaTableView.dataSource = self
               mediaTableView.delegate = self
        mediaTableView.register(AudioTableViewCell.self, forCellReuseIdentifier: String(describing: AudioTableViewCell.self))
        setupView()


    }

    private func setupView() {
        view.addSubviews(mediaTableView)

        NSLayoutConstraint.activate([
            mediaTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mediaTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mediaTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mediaTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }

}

extension AudioViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.numberOfRows(numberOfRowsInSection: section)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = mediaTableView.dequeueReusableCell(withIdentifier: String(describing: AudioTableViewCell.self), for: indexPath) as? AudioTableViewCell
            guard let tableViewCell = cell,
                  let viewModel = viewModel else { return UITableViewCell() }
            tableViewCell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            return tableViewCell

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Music"
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }



}
