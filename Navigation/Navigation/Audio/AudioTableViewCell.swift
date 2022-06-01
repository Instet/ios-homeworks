//
//  AudioTableViewCell.swift
//  Navigation
//
//  Created by Руслан Магомедов on 31.05.2022.
//

import UIKit

class AudioTableViewCell: UITableViewCell {

    var viewModel: AudioTableViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }

            audioTitle.text = viewModel.titleAudio
            audioArtist.text = viewModel.artistAudio
            audioImage.image = UIImage(named: viewModel.imageAudio)
        }
    }

// MARK: - AudioViewElements
    lazy var audioTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    lazy var audioArtist: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        return label
    }()

    lazy var audioImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    func setupView() {
        contentView.addSubviews(audioTitle, audioImage, audioArtist)

        NSLayoutConstraint.activate([
            audioImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            audioImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            audioImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            audioImage.widthAnchor.constraint(equalToConstant: 60),

            audioTitle.topAnchor.constraint(equalTo: audioImage.topAnchor),
            audioTitle.leadingAnchor.constraint(equalTo: audioImage.trailingAnchor, constant: 10),
            audioTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            audioArtist.topAnchor.constraint(equalTo: audioTitle.bottomAnchor, constant: 10),
            audioArtist.leadingAnchor.constraint(equalTo: audioTitle.leadingAnchor),
            audioArtist.trailingAnchor.constraint(equalTo: audioTitle.trailingAnchor),


        ])
    }

//    func configArray(title: String, artist: String, image: String ) {
//        self.audioTitle.text = title
//        self.audioArtist.text = artist
//        self.audioImage.image = UIImage(named: image)
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
