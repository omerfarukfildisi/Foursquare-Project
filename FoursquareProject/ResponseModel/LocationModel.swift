

import Foundation
struct LocationModel : Decodable {
	let address : String?
	let lat : Double?
	let lng : Double?
	let city : String?
	let state : String?
	let country : String?

	enum CodingKeys: String, CodingKey {

		case address = "address"
		case lat = "lat"
		case lng = "lng"
		case city = "city"
		case state = "state"
		case country = "country"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		lng = try values.decodeIfPresent(Double.self, forKey: .lng)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		country = try values.decodeIfPresent(String.self, forKey: .country)
	}

}
