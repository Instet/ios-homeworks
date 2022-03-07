//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {


    var postTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped) // plain лучше
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        postTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.profileHeaderView)
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
        self.navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemGray6
        view.addSubviews(postTableView)
        setupConstaintTableView()
        postTableView.dataSource = self
        postTableView.delegate = self
        scrollViewWillBeginDecelerating(postTableView)
        postTableView.refreshControl = UIRefreshControl()
        postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        var exit = UIBarButtonItem()
        exit = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(exitInLogIn))
        navigationItem.leftBarButtonItem = exit
    }

    @objc func reloadTableView() {
        postTableView.reloadData()

        postTableView.refreshControl?.endRefreshing()

    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 10 {
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
        return postArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell
        cell?.configPostArray(title: postArray[indexPath.row].title,
                              description: postArray[indexPath.row].description,
                              image: postArray[indexPath.row].image,
                              likes: postArray[indexPath.row].likes,
                              views: postArray[indexPath.row].views

        )

        return cell!
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section == 0 else { return nil }

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.profileHeaderView) as! ProfileHeaderView
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)



    }


}


// MARK: практика UIColor(hex:)
public extension UIColor {
    convenience init?(hex: String) {

        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        let length = hexSanitized.count

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255
            b = CGFloat(rgb & 0x0000FF) / 255
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255
            a = CGFloat(rgb & 0x000000FF) / 255

        } else {
            return nil
        }


        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
