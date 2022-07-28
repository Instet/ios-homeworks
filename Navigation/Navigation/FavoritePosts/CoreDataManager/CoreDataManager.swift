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

    lazy var persistenConteiner: NSPersistentContainer = {
        let persistenConteiner = NSPersistentContainer(name: "PostModel")
        persistenConteiner.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        persistenConteiner.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        persistenConteiner.viewContext.automaticallyMergesChangesFromParent = true
        persistenConteiner.viewContext.shouldDeleteInaccessibleFaults = true
        return persistenConteiner
    }()

    lazy var context: NSManagedObjectContext = {
        let context = persistenConteiner.viewContext
        return context
    }()

    lazy var privateContext: NSManagedObjectContext = {
        let context = persistenConteiner.newBackgroundContext()
        return context
    }()


    func savePost(index: Int, post: [Post]) {
        let fetchRequest = PostCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author == %@", post[index].author)
        fetchRequest.predicate = NSPredicate(format: "descript == %@", post[index].description)
        do {
            let count = try privateContext.count(for: fetchRequest)
            if count > 0 {
                let fetchResult = try privateContext.fetch(fetchRequest) as [NSManagedObject]
                if let post = fetchResult.first as? PostCoreDataModel {
                    privateContext.delete(post)
                }
            } else {
                privateContext.perform { [self] in
                    guard let favoritePost = NSEntityDescription.insertNewObject(forEntityName: "PostCoreDataModel", into: self.privateContext) as? PostCoreDataModel else { return }
                    favoritePost.descript = post[index].description
                    favoritePost.image = post[index].image
                    favoritePost.title = post[index].title
                    favoritePost.likes = Int16(post[index].likes)
                    favoritePost.views = Int16(post[index].views)
                    favoritePost.author = post[index].author
                    do {
                        try self.privateContext.save()
                    } catch {
                        print("Ошибка сохранения")
                    }
                }
            }

        } catch let error as NSError {
            print(error.userInfo)
        }
    }


}
