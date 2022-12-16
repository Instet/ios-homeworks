//
//  CoreDataManagerTests.swift
//  NavigationTests
//
//  Created by Руслан Магомедов on 15.10.2022.
//

import XCTest
@testable import Navigation
import CoreData

final class CoreDataManagerTests: XCTestCase {

    let manager = CoreDataManager()
    var arrayPosts = [PostTableViewModel(title: "Fi", description: "Fu", image: "Fa", likes: 1, views: 1, author: "Fe")]
    var fetch: NSFetchRequest<NSManagedObject>!


    override func setUpWithError() throws {
        manager.savePost(index: 0, post: arrayPosts)
        fetch = NSFetchRequest<NSManagedObject>(entityName: "PostCoreDataModel")
    }


    func testManagerWhenAddInContext() {
        DispatchQueue.main.async {
            let result =  try! self.manager.context.fetch(self.fetch)
            XCTAssertEqual(result.count, self.arrayPosts.count)
        }
    }

    func testManagerWhenDeleteInContext() {
        if try! manager.context.count(for: fetch) != 0 {
            let result =  try! manager.context.fetch(fetch)
            manager.context.delete(result[0])
            try! manager.context.save()
            print("⚠️произошло удаление")
            XCTAssertEqual(try! manager.context.count(for: fetch), 0)

        } else {
            print("🔴нет данных")
        }


    }
}
