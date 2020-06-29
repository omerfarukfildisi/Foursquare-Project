
//
//  VenueSearchRequest.swift
//  FoursquareProject
//
//  Created by Ömer Faruk Fildişi on 5.08.2019.
//  Copyright © 2019 Ömer Faruk Fildişi. All rights reserved.
//


import Foundation

enum VenueServices {
    case search(near: String, query: String)
    case photo(venueId: String)
    case tips(venueId: String)
}

extension VenueServices: Service {
    var baseURL: String {
        return "https://api.foursquare.com"
    }
    
    var path: String {
        switch self {
        case .search(_):
            return "/v2/venues/search"
        case .photo(let venueId):
            return "/v2/venues/\(venueId)/photos"
        case .tips(let venueId):
            return "/v2/venues/\(venueId)/tips"
        }
    }

    
    var parameters: [String: Any]? {
        // default params
        // &client_id=ZP4PCUE4WG1XHZJ4F05B2WR0MU30GIH35GUCY0GRI3O0XLWI&client_secret=ZGHWC0UXSFPM5SERDS1YNXEINGEHTMXRL1NXE0UGAFYCFUIV&v=20190614
        var params: [String: Any] = ["client_id": "3PB5ADTIZJHT43L32XZSL5GMPEFZBYP3QQ4N0YJFJK3CL31Y",
                                     "client_secret" : "1H42ETWIDACIQWMVGVJU0FTMLVAQY3ZJTIZE1B3D5WEKUZFW",
                                     "v" : "20190614"]
        
        switch self {
        case .search(let near, let query):
            params["near"] = near
            params["query"] = query
        case .photo(_):
            break
        case .tips(_):
            break
        
        }
        
        return params
    }
    
    var method: ServiceMethod {
        switch self {
        case .search(_):
            return .get
        case .photo(_):
            return .get
        case .tips(_):
            return .get
            
        }
    }
}
