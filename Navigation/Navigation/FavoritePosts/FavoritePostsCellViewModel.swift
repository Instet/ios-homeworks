//
//  FavoritePostsCellViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 19.07.2022.
//

import Foundation

struct FavoritePostsCellViewModel {

    var post: FavoritePost

    var title: String {
        return post.title
    }

    var description: String {
        return post.description
    }

    var image: String {
        return post.image
    }
    var likes: UInt {
        return UInt(post.likes)
    }

    var views: UInt {
        return UInt(post.views)
    }

}
