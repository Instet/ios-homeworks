//
//  Post.swift
//  Navigation
//
//  Created by Руслан Магомедов on 13.02.2022.
//

import Foundation

public struct Post {

    public var title: String
    public var description: String
    public var image: String
    public var likes: UInt
    public var views: UInt

}

public var postOne = Post(title: "Российский Apple Store приостановил продажи",
                   description: "Apple остановила продажи своих гаджетов на территории России и прекратила поставки в страну. Помимо этого, купертиновцы подтвердили ограничение работы Apple Pay.",
                   image: "apple",
                   likes: 0,
                   views: 0)

public var postTwo = Post(title: "Россию отключают от SWIFT",
                   description: "Ну все зря учился 😂",
                   image: "swift",
                   likes: 0,
                   views: 0)

public var postThree = Post(title: "Вышел первый тизер сериала по книгам Толкина",
                     description: "В Сети появился первый тизер сериала \"Властелин колец: Кольца власти\" по книгам Толкина.",
                     image: "rings",
                     likes: 0,
                     views: 0)

public var postFour = Post(title: "Geely Coolray",
                    description: "Тот случай когда выхлопных труб больше чем цилиндров в двигателе",
                    image: "geely",
                    likes: 0,
                    views: 0)


public var postArray: [Post] = [postOne, postTwo, postThree, postFour]
