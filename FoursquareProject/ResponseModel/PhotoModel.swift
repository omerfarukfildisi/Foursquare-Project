


import Foundation
struct PhotoModel : Decodable {
    
    let items : [ItemsPhotoModel]?
    
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([ItemsPhotoModel].self, forKey: .items)
       
    }
    
}
