//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 12.02.2022.
//

import UIKit
import FirebaseAuth
import UniformTypeIdentifiers
//import RealmSwift

class ProfileViewController: UIViewController {

    var userService: UserServiceProtocol
    var userLogin: String
    private let coordinator: ProfileCoordinator?
    private var viewModel: ProfileViewModelProtocol?
    var timeSeconds = 15 {
        didSet {
            ProfileHeaderView.timerLabel.text = String(timeSeconds)
        }
    }
    private var cellIndex = 0


    static var postTableView: UITableView = {
        let postTableView = UITableView(frame: .zero, style: .grouped)
        postTableView.translatesAutoresizingMaskIntoConstraints = false
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        postTableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self))
        postTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        postTableView.separatorInset = .zero
        postTableView.separatorStyle = .none
        postTableView.backgroundColor = .createColor(lightMod: .systemGray6, darkMod: .darkGray)
        postTableView.dragInteractionEnabled = true
        return postTableView
    }()

    init(coordinator: ProfileCoordinator?,
         viewModel: ProfileViewModelProtocol?,
         userService: UserServiceProtocol,
         userLogin: String
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.userService = userService
        self.userLogin = userLogin
        super.init(nibName: nil, bundle: nil)
        let exitBarButton = UIBarButtonItem(title: "Exit",
                                            style: .plain,
                                            target: self, action: #selector(exitProfile))
        self.navigationItem.rightBarButtonItem = exitBarButton
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func exitProfile() {
        do {
            try Auth.auth().signOut()
            coordinator?.exitProfile()
        } catch {
            print(error.localizedDescription)
        }
//
//        let currentUser = RealmService.shared.fetch()?.last
//        guard currentUser != nil else {
//            print("currentUser nil")
//            return
//        }
        UserDefaults.standard.set(false, forKey: "isLogined")
//        RealmService.shared.deleteUser(currentUser!)

    }

    private func setupConstaintTableView() {
        NSLayoutConstraint.activate([
            ProfileViewController.postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProfileViewController.postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            ProfileViewController.postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ProfileViewController.postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        view.backgroundColor = .createColor(lightMod: .systemGray6, darkMod: .darkGray)
        view.addSubviews(ProfileViewController.postTableView)
        setupConstaintTableView()
        ProfileViewController.postTableView.dataSource = self
        ProfileViewController.postTableView.delegate = self
        ProfileViewController.postTableView.refreshControl = UIRefreshControl()
        ProfileViewController.postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    //    timer()
        ProfileViewController.postTableView.dragDelegate = self
        ProfileViewController.postTableView.dropDelegate = self
    }

    @objc func reloadTableView() {
        ProfileViewController.postTableView.reloadData()
        ProfileViewController.postTableView.refreshControl?.endRefreshing()
    }

    // MARK: - TASK 10
    
    func timer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.timeSeconds -= 1
            if self.timeSeconds == 0 {
                self.coordinator?.showNetology()
                timer.invalidate()
                ProfileHeaderView.timerLabel.isHidden = true
            }
        }
    }


    func reload() {
        var timerSecond = 40
        DispatchQueue.global(qos: .utility).async {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                timerSecond -= 1
                if timerSecond == 0 {
                    DispatchQueue.main.async {
                        ProfileViewController.postTableView.reloadData()
                    }
                }
            }
            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }

    }

    @objc func tappedPost() {
        guard let viewModel = viewModel else { return }
        CoreDataManager.shared.savePost(index: cellIndex, post: viewModel.postArray)
    }

}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

// MARK: - TASK 11 (искуственно созданная ошибка при закомментировании массива с постами)

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            guard let count = try?viewModel?.numberOfRows() else {
                preconditionFailure("Массив постов пуст")
            }
            return count
        } else {
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1 {
            let cell = ProfileViewController.postTableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell
            guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
            let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
            tableViewCell.viewModel = cellViewModel
            let tapGesture = UITapGestureRecognizer()
            tapGesture.numberOfTapsRequired = 2
            tapGesture.addTarget(self, action: #selector(tappedPost))
            cell?.addGestureRecognizer(tapGesture)
            return tableViewCell

        } else {

            let cell = ProfileViewController.postTableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell

            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self)) as! ProfileHeaderView
        if let user = userService.getUser(name: userLogin) {
            headerView.currentUser(user: user)
        }
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
            guard var viewModel = viewModel else { return }
            viewModel.postArray[indexPath.row].views += UInt(1)
            self.cellIndex = indexPath.row
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
        // MARK: - TASK 10
        // обновляем просмотры
        reload()

    }

}

// MARK: - UITableViewDragDelegate
extension ProfileViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if indexPath.section == 1 {
            guard let viewModel = viewModel else { return [] }

            let descriptionPost = viewModel.postArray[indexPath.row].description
            let imagePost = viewModel.postArray[indexPath.row].image

            let descriptionItempProvider = NSItemProvider(object: descriptionPost as NSString)
            let imageItemProvider = NSItemProvider(object: imagePost ?? UIImage())

            let descriptionDragItem = UIDragItem(itemProvider: descriptionItempProvider)
            let imageDragItem = UIDragItem(itemProvider: imageItemProvider)

            return [descriptionDragItem, imageDragItem]
        }
        return []
    }


}

// MARK: - UITableViewDropDelegate
extension ProfileViewController: UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {

        return session.hasItemsConforming(toTypeIdentifiers: [UTType.text.identifier, UTType.image.identifier])
    }

    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {

        var dropProrosal = UITableViewDropProposal(operation: .cancel)

        guard session.items.count == 2 else { return dropProrosal }

        if tableView.hasActiveDrag {
         //   if tableView.isEditing {
                dropProrosal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
          //  }
        } else {
            dropProrosal = UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
        return dropProrosal
    }


    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = tableView.numberOfRows(inSection: 1)
            destinationIndexPath = IndexPath(row: row, section: 1)
        }

        var descriptionNewPost: String = ""
        var imagePost: UIImage?


        coordinator.session.loadObjects(ofClass: NSString.self) { [self] items in
            guard let stringItems = items as? [String],
                  let item = stringItems.first else {
                return
            }
            descriptionNewPost = item
        }

        coordinator.session.loadObjects(ofClass: UIImage.self) { [self] items in
            guard let stringItems = items as? [UIImage],
                  let item = stringItems.first else {
                return
            }
            imagePost = item

            insertNewPost(in: tableView, with: descriptionNewPost, image: imagePost!, destination: destinationIndexPath)
        }

    }

}


extension ProfileViewController {

    private func insertNewPost(in tableView: UITableView, with description: String, image: UIImage, destination: IndexPath) {
        let newPost = Post(title:  "Drag&Drop",
                           description: description,
                           image: image,
                           likes: 0,
                           views: 0,
                           author:  "Drag&Drop")
        

        viewModel?.postArray.insert(newPost, at: destination.row)
        tableView.reloadData()
    }

}
