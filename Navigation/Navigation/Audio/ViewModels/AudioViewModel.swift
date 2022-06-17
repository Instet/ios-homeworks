//
//  MediaViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 31.05.2022.
//

import Foundation
import UIKit

final class AudioViewModel {

    var audioLibrary: [(title: String, artist: String, url: URL?, image: String?)] = []

    init() {
        for i in nameAudioArray.enumerated() {
            let value = i.element
            audioLibrary.append((title: value.title,
                                 artist: value.artist,
                                 url: URL(fileURLWithPath: Bundle.main.path(forResource: value.url, ofType: "mp3")!),
                                 image : value.image))

        }

    }

    private var nameAudioArray: [Audio] = [
        Audio(title: "Oh Yeah", artist: "The Subways", url: "Music1", image: "Subways"),
        Audio(title: "Куча мыслей в голове", artist: "#####", url: "Music2", image: "#####"),
        Audio(title: "Teddy Picker", artist: "Arctic Monkeys", url: "Music3", image: "Arctic"),
        Audio(title: "Old Yellow Bricks", artist: "Arctic Monkeys", url: "Music4", image: "Arctic"),
        Audio(title: "D is for Dangerous", artist: "Arctic Monkeys", url: "Music5", image: "Arctic")
    ]

}

