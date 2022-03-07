//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    var postTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        postTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self))
        postTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        postTableView.separatorInset = .zero
        return postTableView
    }()

    private func setupConstaintTableView() {

        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        view.backgroundColor = .systemGray6
        view.addSubviews(postTableView)
        setupConstaintTableView()
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.refreshControl = UIRefreshControl()
        postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        var exit = UIBarButtonItem()
        exit = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitInLogIn))
        navigationItem.leftBarButtonItem = exit
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // MARK: скрываю NavigationBar при скроллинге
        scrollViewWillBeginDecelerating(postTableView)
    }

    @objc func reloadTableView() {
        postTableView.reloadData()
        postTableView.refreshControl?.endRefreshing()

    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

    @objc func exitInLogIn() {
        let login = LogInViewController()
        navigationController?.pushViewController(login, animated: true)

    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return postArray.count
        } else {
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1 {
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            cell.configPostArray(title: postArray[indexPath.row].title,
                                  description: postArray[indexPath.row].description,
                                  image: postArray[indexPath.row].image,
                                  likes: postArray[indexPath.row].likes,
                                  views: postArray[indexPath.row].views)

            return cell
        } else {
            guard let cell = postTableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as? PhotosTableViewCell else { return UITableViewCell()}

            return cell
        }
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self)) as! ProfileHeaderView
        return headerView
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.deselectRow(at: indexPath, animated: false)
            postArray[indexPath.row].views += UInt(1)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }

    }


}
