//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.07.2022.
//

import UIKit

class FavoritePostsViewController: UIViewController {

    private let coordinator: FavoritesCoordinator?
    var filterPost: [FavoritePost] = []
    var author = ""
    var isFiltred = false


    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        return tableView
    }()

    init(coordinator: FavoritesCoordinator?) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.getPost {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(filterAuthor))
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash,
                                          target: self,
                                          action: #selector(clearFilter))
        navigationItem.leftBarButtonItem = clearButton
        navigationItem.rightBarButtonItem = filterButton
        tableView.delegate = self
        tableView.dataSource = self
        setupView()

    }

    @objc func filterAuthor() {
        let alertController = UIAlertController(title: "Search",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter the author's name"
            textField.addTarget(self, action: #selector(self.enterAuthor(_:)), for: .editingChanged)
        }
        let searchAction = UIAlertAction(title: "Ok", style: .default) { action in
            CoreDataManager.shared.update(author: self.author) { array in
                self.filterPost = array
                self.isFiltred = true
                print(self.filterPost)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(searchAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }


    @objc func clearFilter() {
        let alertController = UIAlertController(title: "Reset filter?",
                                                message: nil,
                                                preferredStyle: .alert)
        let resetAlert = UIAlertAction(title: "Yes", style: .default) { _ in
            CoreDataManager.shared.getPost {
                self.isFiltred = false
                self.tableView.reloadData()
            }
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(resetAlert)
        self.present(alertController, animated: true)
    }



    @objc func enterAuthor(_ textField: UITextField) {
        guard let text = textField.text else { return }
        author = text
    }


    private func setupView() {
        view.addSubviews(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


extension FavoritePostsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { action, view, handler in
            CoreDataManager.shared.delete(index: indexPath.row) {
                // debug
                self.tableView.reloadData()
            }
            handler(true)
        }
        if !isFiltred {
            let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipe
        }
        return nil
    }

}

extension FavoritePostsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isFiltred {
            return CoreDataManager.shared.postArray.count
        } else {
            return filterPost.count
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else { return  UITableViewCell()}
        if !isFiltred {
            cell.favoritesViewModel = FavoritePostsCellViewModel(post: CoreDataManager.shared.postArray[indexPath.row])

            return cell
        } else {
            cell.favoritesViewModel = FavoritePostsCellViewModel(post: self.filterPost[indexPath.row])

            return cell

        }

    }


}
