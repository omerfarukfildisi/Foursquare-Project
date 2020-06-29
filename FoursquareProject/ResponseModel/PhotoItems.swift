//
//  PhotoItems.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 28.06.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation
struct PhotoItems : Decodable {
    let id : String?
    let createdAt : Int?
   
    let prefix : String?
    let suffix : String?
    let width : Int?
    let height : Int?
   
    let visibility : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case createdAt = "createdAt"
        case source = "source"
        case prefix = "prefix"
        case suffix = "suffix"
        case width = "width"
        case height = "height"
        case user = "user"
        case checkin = "checkin"
        case visibility = "visibility"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        
        prefix = try values.decodeIfPresent(String.self, forKey: .prefix)
        suffix = try values.decodeIfPresent(String.self, forKey: .suffix)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
       
        visibility = try values.decodeIfPresent(String.self, forKey: .visibility)
    }
    
}

