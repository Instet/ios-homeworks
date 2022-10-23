//
//  PostCoreDataModel+CoreDataProperties.swift
//
//
//  Created by Руслан Магомедов on 23.10.2022.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc (PostCoreDataModel)
class PostCoreDataModel: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCoreDataModel> {
        return NSFetchRequest<PostCoreDataModel>(entityName: "PostCoreDataModel")
    }

    @NSManaged public var author: String?
    @NSManaged public var descript: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var likes: Int16
    @NSManaged public var title: String?
    @NSManaged public var views: Int16

}

extension PostCoreDataModel : Identifiable {

}
