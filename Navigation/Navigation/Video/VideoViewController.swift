//
//  VideoViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 03.06.2022.
//

import UIKit
import AVFoundation


class VideoViewController: UIViewController {

    private let coordinator: VideoCoordinator?
    private let viewModel: VideoViewModel?

    lazy var videoTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
    
        
        return table
    }()
    
    init(coordinator: VideoCoordinator?,
         viewModel: VideoViewModel?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.register(VideoTableViewCell.self,
                                forCellReuseIdentifier: String(describing: VideoTableViewCell.self))
    }


    private func setupConstraints() {
        view.addSubviews(videoTableView)
        NSLayoutConstraint.activate([

            videoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            videoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            videoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])


    }

}

extension VideoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension VideoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Video"
    }


}
