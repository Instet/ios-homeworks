//
//  VideoTableViewCell.swift
//  Navigation
//
//  Created by Руслан Магомедов on 03.06.2022.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    lazy var titleVideo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraits()
    }


    private func setupConstraits() {
        contentView.addSubviews(titleVideo)

        NSLayoutConstraint.activate([
            titleVideo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleVideo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleVideo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
