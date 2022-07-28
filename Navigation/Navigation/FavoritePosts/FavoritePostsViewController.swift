//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.07.2022.
//

import UIKit
import CoreData

class FavoritePostsViewController: UIViewController {

    private let coordinator: FavoritesCoordinator?
    var author = ""

    private lazy var fetchResultsController: NSFetchedResultsController<PostCoreDataModel> = {
        let request = PostCoreDataModel.fetchRequest()
        let sortDesriptor = NSSortDescriptor(key: "author", ascending: true)
        request.sortDescriptors = [sortDesriptor]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                managedObjectContext: CoreDataManager.shared.context,
                                                                sectionNameKeyPath: nil,
                                                                cacheName: nil)
        fetchResultsController.delegate = self
        return fetchResultsController

    }()


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

    func fetchFavoritePosts() {
        fetchResultsController.fetchRequest.predicate = nil
        CoreDataManager.shared.context.perform {
            do {
                try self.fetchResultsController.performFetch()
                self.tableView.reloadData()
            } catch let error as NSError {
                print(error.userInfo)
            }
        }
    }

    func fetchFilterFavoritePost(author: String) {
        fetchResultsController.fetchRequest.predicate = NSPredicate(format: "author CONTAINS[cd] %@", author)
        CoreDataManager.shared.context.perform {
            do {
                try self.fetchResultsController.performFetch()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error as NSError {
                print(error.userInfo)
            }
        }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoritePosts()

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
            self.fetchFilterFavoritePost(author: self.author)
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
            self.fetchFavoritePosts()
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
            let postDelete = self.fetchResultsController.object(at: indexPath)
            CoreDataManager.shared.context.delete(postDelete)
            do {
                try CoreDataManager.shared.context.save()
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            handler(true)
        }
            let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipe
        }


}

extension FavoritePostsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fetchResultsController.fetchedObjects?.count ?? 0

    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as? PostTableViewCell else { return  UITableViewCell()}
        let postObject = fetchResultsController.object(at: indexPath)
        let post = FavoritePost(title: postObject.title ?? "",
                                description: postObject.descript ?? "",
                                image: postObject.image ?? "",
                                likes: Int(postObject.likes),
                                views: Int(postObject.views),
                                author: postObject.author ?? "")
        cell.favoritesViewModel = FavoritePostsCellViewModel(post: post)
            return cell

    }
}



extension FavoritePostsViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            self.tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { fallthrough }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { fallthrough }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                  let newIndexPath = newIndexPath else { fallthrough }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { fallthrough }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

}
