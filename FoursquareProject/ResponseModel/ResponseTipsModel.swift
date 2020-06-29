

import Foundation

struct FoursquareResponseTipsModel: Decodable {
    var response: ResponseTipsModel?
}

struct ResponseTipsModel : Decodable {
    let tips: TipsModel?
}
