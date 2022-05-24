//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Руслан Магомедов on 04.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var viewModel: PostTableViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else {
                return
            }
            postTitle.text = viewModel.title
            postDescription.text = viewModel.description
            postImage.image = UIImage(named: viewModel.image)
            postLikes.text = "Likes: \(viewModel.likes)"
            postViews.text = "Views: \(viewModel.views)"
        }
    }

    var postTitle: UILabel = {
        let postTitle = UILabel()
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        postTitle.font =  .systemFont(ofSize: 20, weight: .bold)
        postTitle.textColor = .black
        postTitle.numberOfLines = 2
        return postTitle
    }()

    var postImage: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.backgroundColor = .black
        postImage.contentMode = .scaleAspectFit
        return postImage
    }()

    var postDescription: UILabel = {
        let postDescription = UILabel()
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.font = UIFont.systemFont(ofSize: 14)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        return postDescription
    }()

    var postLikes: UILabel = {
        let postLikes = UILabel()
        postLikes.translatesAutoresizingMaskIntoConstraints = false
        postLikes.font = .systemFont(ofSize: 16)
        postLikes.textColor = .black
        return postLikes
    }()


    var postViews: UILabel = {
        let postViews = UILabel()
        postViews.translatesAutoresizingMaskIntoConstraints = false
        postViews.font = .systemFont(ofSize: 16)
        postViews.textColor = .black
        return postViews
    }()

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),

            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: Constants.indent),

            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: Constants.indent),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),

            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent),

            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: Constants.indent),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.indent)

        ])

    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postTitle, postImage, postDescription, postLikes, postViews)
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
