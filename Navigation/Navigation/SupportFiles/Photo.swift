//
//  Photo.swift
//  Navigation
//
//  Created by Руслан Магомедов on 07.03.2022.
//

import UIKit

var arrayPhotos: [UIImage] = []

func appendArrayPhotos() {
    for i in 1...20 {
        arrayPhotos.append(UIImage(named: "\(i)") ?? UIImage())
    }
}
