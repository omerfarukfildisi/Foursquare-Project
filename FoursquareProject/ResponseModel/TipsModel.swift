

import Foundation
struct TipsModel : Decodable {
    let count : Int?
    let items : [ItemsModel]
    
    enum CodingKeys: String, CodingKey {
        
        case count = "count"
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        items = try values.decodeIfPresent([ItemsModel].self, forKey: .items)!
    }
    
}

