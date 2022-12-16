//
//  Post.swift
//  Navigation
//
//  Created by Руслан Магомедов on 13.02.2022.
//

import Foundation
import UIKit

struct Post: Equatable {
    var title: String
    var description: String
    var image: UIImage?
    var likes: UInt
    var views: UInt
    var author: String

}
