//
//  Source.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 1.07.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation
struct Source : Decodable {
  
    let prefix : String
    let suffix : String
    
    
    enum CodingKeys: String, CodingKey {
        
        case prefix = "prefix"
        case suffix = "suffix"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        prefix = try values.decodeIfPresent(String.self, forKey: .prefix)!
        suffix = try values.decodeIfPresent(String.self, forKey: .suffix)!
        
    }
    
}
