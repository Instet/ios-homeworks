//
//  FavoritePostsCellViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 19.07.2022.
//

import UIKit

struct FavoritePostsCellViewModel {

    var post: FavoritePost

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
        return UInt(post.likes)
    }

    var views: UInt {
        return UInt(post.views)
    }

    var author: String {
        return post.author
    }

}
