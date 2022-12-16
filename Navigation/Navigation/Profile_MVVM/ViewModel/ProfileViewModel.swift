//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 17.05.2022.
//

import Foundation
import UIKit

protocol ProfileViewModelProtocol {

    func numberOfRows() throws -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableViewModel
    var postArray: [Post] { get set }
}

final class ProfileViewModel: ProfileViewModelProtocol {

    public var postArray: [Post] = [
        
        // здесь можно закомментировать содержимое массива для вызова ошибки

        Post(title: "Российский Apple Store приостановил продажи",
             description: "Apple остановила продажи своих гаджетов на территории России и прекратила поставки в страну. Помимо этого, купертиновцы подтвердили ограничение работы Apple Pay.",
             image: UIImage(named: "apple"),
             likes: 28,
             views: 543,
             author: "Apple"),

        Post(title: "Россию отключают от SWIFT",
             description: "Ну все зря учился 😂",
             image: UIImage(named: "swift"),
             likes: 23,
             views: 3432,
             author: "Swift"),

        Post(title: "Вышел первый тизер сериала по книгам Толкина",
             description: "В Сети появился первый тизер сериала \"Властелин колец: Кольца власти\" по книгам Толкина.",
             image: UIImage(named: "rings"),
             likes: 1212,
             views: 4690,
             author: "Киномакс"),

        Post(title: "Geely Coolray",
             description: "Тот случай когда выхлопных труб больше чем цилиндров в двигателе",
             image: UIImage(named: "geely"),
             likes: 41,
             views: 312,
             author: "Автомир")
    ]

// MARK: - TASK 11
    
    func numberOfRows() throws -> Int {
        if postArray.count != 0 {
            return postArray.count
        } else {
            throw AuthorizationError.badAuthData
        }
    }

    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableViewModel {
        let post = postArray[indexPath.row]
        return PostTableViewModel(post: post)
    }

}
