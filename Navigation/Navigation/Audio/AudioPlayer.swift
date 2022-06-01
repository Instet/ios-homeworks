//
//  AudioPlayer.swift
//  Navigation
//
//  Created by Руслан Магомедов on 01.06.2022.
//

import Foundation
import UIKit
import AVFoundation

class AudioPlayer: UIViewController {

    var player: AVAudioPlayer!

    lazy var playButton: UIButton = {
        let button = UIButton()
        return button
    }()

    lazy var stopButton: UIButton = {
        let button = UIButton()
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        return button
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

    }


    func setupButton() {

    }

}


