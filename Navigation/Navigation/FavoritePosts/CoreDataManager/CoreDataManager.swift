//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Руслан Магомедов on 18.07.2022.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    var postArray: [FavoritePost] = []

    lazy var persistenConteiner: NSPersistentContainer = {
        let persistenConteiner = NSPersistentContainer(name: "PostModel")
        persistenConteiner.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return persistenConteiner
    }()

    lazy var mainContext: NSManagedObjectContext = {
        let context = persistenConteiner.viewContext
        return context
    }()

    lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistenConteiner.newBackgroundContext()
        return context
    }()

    func savePost(index: Int, post: [Post]){
        print("save in background")
        backgroundContext.perform {
            guard let favoritePost = NSEntityDescription.insertNewObject(forEntityName: "PostCoreDataModel", into: self.backgroundContext) as? PostCoreDataModel else { return }
            favoritePost.descript = post[index].description
            favoritePost.image = post[index].image
            favoritePost.title = post[index].title
            favoritePost.likes = Int16(post[index].likes)
            favoritePost.views = Int16(post[index].views)
            favoritePost.author = post[index].author
            do {
                try self.backgroundContext.save()
            } catch {
                print("Ошибка сохранения")
            }
        }
    }

    func getPost(callback: () -> Void) {
        CoreDataManager.shared.postArray.removeAll()
        let fetchRequest = PostCoreDataModel.fetchRequest()
        do {
            let posts = try backgroundContext.fetch(fetchRequest)
            for i in posts {
                let tempPost = FavoritePost(title: i.title ?? "",
                                            description: i.descript ?? "",
                                            image: i.image ?? "",
                                            likes: Int(i.likes),
                                            views: Int(i.views),
                                            author: i.author ?? "")
                CoreDataManager.shared.postArray.append(tempPost)
            }


        } catch {
            print("Ошибка получения")
            fatalError()
        }
        callback()
    }

    func update(author: String, completion: @escaping ([FavoritePost]) -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            var filterPost: [FavoritePost] = []
            let fetchRequest = PostCoreDataModel.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "author == %@", author)
            do {
                let filtred = try self.backgroundContext.fetch(fetchRequest)
                for post in filtred {
                    let tempPost = FavoritePost(title: post.title ?? "",
                                                description: post.descript ?? "",
                                                image: post.image ?? "",
                                                likes: Int(post.likes),
                                                views: Int(post.views),
                                                author: post.author ?? "")
                    filterPost.append(tempPost)
                }
            } catch {
                fatalError()

            }
            completion(filterPost)
        }

    }

    func delete(index: Int, callback: () -> Void) {
        let fetchRequest = PostCoreDataModel.fetchRequest()
        do {
            let posts = try backgroundContext.fetch(fetchRequest)
            for i in posts.indices {
                if i == index {
                    backgroundContext.delete(posts[i])
                    CoreDataManager.shared.postArray.remove(at: i)
                }
            }
            try backgroundContext.save()

        } catch {
            print("Ошибка получения")
            fatalError()
        }
        callback()

    }






}