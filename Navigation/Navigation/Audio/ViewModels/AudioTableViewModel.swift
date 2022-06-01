//
//  MediaTableViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 31.05.2022.
//

import Foundation

struct AudioTableViewModel {

    var audio: Audio

    var titleAudio: String {
        return audio.title
    }
    var artistAudio: String {
        return audio.artist
    }
    var imageAudio:  String {
        return audio.image
    }

}
