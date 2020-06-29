

import Foundation
struct VenueResponseModel : Decodable {
	let id : String?
	let name : String?
	let location : LocationModel?


	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case location = "location"
		case categories = "categories"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		location = try values.decodeIfPresent(LocationModel.self, forKey: .location)
	//	categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
	}

}
