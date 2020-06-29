//
//  VenuesController.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 5.08.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//

import Foundation


   
    enum VenuesService {
        case characters(name: String)
        case character(city: String)
    }
/*
extension VenuesService: Service {
     var parameters: [String : Any]?
    
    
    
    
    
    var area: String {
        return area
    }
    
    var type: String {
        return type
    }
    
       
        var baseURL: String
        {
            return "https://api.foursquare.com/v2/venues/search?near=\(area)&query=\(type)&client_id=ZP4PCUE4WG1XHZJ4F05B2WR0MU30GIH35GUCY0GRI3O0XLWI&client_secret=ZGHWC0UXSFPM5SERDS1YNXEINGEHTMXRL1NXE0UGAFYCFUIV&v=20190614"
        }
    
        var path: String {
            switch self {
            case .characters(_):
                return "/v1/public/characters"
            case .character(let city):
                return "/v1/public/characters/\(city)"
            }
        }
        
   
        var method: ServiceMethod {
            return .get
        }
 */

