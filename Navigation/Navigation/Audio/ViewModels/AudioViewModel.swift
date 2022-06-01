//
//  MediaViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 31.05.2022.
//

import Foundation

final class AudioViewModel {

    public var audioArray: [Audio] = [
        Audio(title: "Oh Yeah", artist: "The Subways", image: "Subways"),
        Audio(title: "Куча мыслей в голове", artist: "#####", image: "#####"),
        Audio(title: "Teddy Picker", artist: "Arctic Monkeys", image: "Arctic"),
        Audio(title: "Old Yellow Bricks", artist: "Arctic Monkeys", image: "Arctic"),
        Audio(title: "D is for Dangerous", artist: "Arctic Monkeys", image: "Arctic")
    ]

    func cellViewModel(forIndexPath indexPath: IndexPath) -> AudioTableViewModel {
        let audio = audioArray[indexPath.row]
        return AudioTableViewModel(audio: audio)
    }

    func numberOfRows(numberOfRowsInSection section: Int) -> Int {
            return audioArray.count
    }
}

