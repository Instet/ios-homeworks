//
//  VideoViewModel.swift
//  Navigation
//
//  Created by Руслан Магомедов on 03.06.2022.
//

import Foundation
import UIKit

final class VideoViewModel {

    var videoArray: [(title: String, url: String)] = []

    init() {
        appendVideo()
    }
    
//    func appendVideo() {
//        videoArray.removeAll()
//        videoArray.append((title: "Add YouTube Video in App Swift 5",
//                           url: URL(fileURLWithPath: "https://youtu.be/bsM1qdGAVbU")))
//        videoArray.append((title: "Eisbrecher-Was ist hier los?",
//                           url: URL(fileURLWithPath: "https://youtu.be/HRRl8SHfOPI")))
//        videoArray.append((title: "Don Broco - Manchester Super Reds No.1 Fan",
//                           url: URL(fileURLWithPath: "https://youtu.be/TL_gq84CRpo")))
//        videoArray.append((title: "Rammstein - Puppe НА РУССКОМ (ПЕРЕВОД)",
//                           url: URL(fileURLWithPath: "https://youtu.be/OjH8Vb7zmXQ")))
//        videoArray.append((title: "Eisbrecher - FAKK (Offizielles Video)",
//                           url: URL(fileURLWithPath: "https://youtu.be/yNXMs_y7n9c")))
//    }


    func appendVideo() {
        videoArray.removeAll()
        videoArray.append((title: "Add YouTube Video in App Swift 5",
                           url: "bsM1qdGAVbU"))
        videoArray.append((title: "Как играть на бас-гитаре (для новичков)",
                           url: "EblaED750dY"))
        videoArray.append((title: "8 String VS Djent Stick",
                           url: "g_cpVyZ_ZSY"))
        videoArray.append((title: "Multithreading в swift с нуля: урок 1 - Thread & Pthread",
                           url: "JtDf-S1uLLs"))
        videoArray.append((title: "8-летняя Джулия исполняет хардкор",
                           url: "KGJTg0Rhor0"))
    }

}
