//
//  ResponsePhoto.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 8.07.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//


import Foundation

struct FoursquareResponsePhotosModel: Decodable {
    var response: PhotosModel?
}

struct PhotosModel: Decodable {
    let photos : PhotoModel?
}
