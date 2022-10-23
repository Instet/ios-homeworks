//
//  PostTableViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 19.05.2022.
//

import UIKit

struct PostTableViewModel {

    var post: Post

    var title: String {
        return post.title
    }

    var description: String {
        return post.description
    }

    var image: UIImage {
        return post.image ?? UIImage()
    }
    var likes: UInt {
        return post.likes
    }

    var views: UInt {
        return post.views
    }

    var author: String {
        return post.author
    }

}

